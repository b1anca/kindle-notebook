# frozen_string_literal: true

module KindleNotebook
  class AmazonAuth
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def sign_in
      session.visit(KindleNotebook.configuration.url)
      if valid_cookies?
        puts 'Session restored!'
        return session
      end

      submit_sign_in_form
      submit_otp_form if mfa?
      session.save_cookies
      puts "You're signed in!"
    end

    private

    attr_reader :email, :password

    def session
      KindleNotebook.session
    end

    def valid_cookies?
      session.find_latest_cookie_file
      session.restore_cookies
      session.refresh
      session.has_current_path?("/kindle-library")
    end

    def submit_otp_form
      print "Enter OTP: "
      otp = gets.chomp
      session.fill_in("auth-mfa-otpcode", with: otp)
      session.first("#auth-signin-button").click
      check_errors
    end

    def submit_sign_in_form
      session.click_button("Sign in with your account", match: :first)
      fill_in_credentials
      session.check("rememberMe")
      session.first("#signInSubmit").click
      check_errors
    end

    def fill_in_credentials
      session.fill_in("ap_email", with: email)
      session.fill_in("ap_password", with: password)
    end

    def mfa?
      session.current_path.match?(%r{ap/mfa})
    end

    def check_errors
      return unless session.all("h4", text: "There was a problem").any?

      message = session.all("div", class: "a-alert-content").map(&:text).join(", ") || "There was a problem"
      raise StandardError, message
    end
  end
end
