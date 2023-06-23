# frozen_string_literal: true

module KindleNotebook
  class Client
    attr_reader :session

    def initialize(email: KindleNotebook.configuration.login,
                   password: KindleNotebook.configuration.password,
                   headless_mode: KindleNotebook.configuration.headless_mode,
                   selenium_driver: KindleNotebook.configuration.selenium_driver)
      @email = email
      @password = password
      @headless_mode = headless_mode
      @selenium_driver = selenium_driver.to_sym
      @session = new_capybara_session
    end

    def books
      @books ||= fetch_books
    end

    def sign_in
      AmazonAuth.new(password: password, email: email).sign_in
    end

    private

    attr_reader :email, :password, :headless_mode, :selenium_driver

    def fetch_books
      session.find("ul#cover").all("li").map do |element|
        Book.new(author: element.find("div", id: /author-/).text,
                 title: element.find("div", id: /title-/).text,
                 asin: element.find("div", match: :first)["data-asin"])
      end
    end

    def new_capybara_session
      chrome_driver
      firefox_driver

      KindleNotebook.session = Capybara::Session.new(selenium_driver)
    end

    def firefox_driver
      Capybara.register_driver :firefox do |app|
        options = Selenium::WebDriver::Firefox::Options.new
        options.add_argument("--headless") if headless_mode

        Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
      end
    end

    def chrome_driver
      Capybara.register_driver :chrome do |app|
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument("--headless") if headless_mode
        options.add_argument("--disable-gpu")
        options.add_argument("--no-sandbox")

        Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
      end
    end
  end
end
