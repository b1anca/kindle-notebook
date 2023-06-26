# frozen_string_literal: true

RSpec.describe KindleNotebook::Client do
  describe "#sign_in" do
    let(:url) { KindleNotebook.configuration.url }

    before do
      landing_page = File.read("spec/support/pages/landing.html")
      signin_page = File.read("spec/support/pages/signin.html")
      proxy.stub(url).and_return(body: landing_page, content_type: "text/html")
      proxy.stub("#{url}ap/signin").and_return(body: signin_page, content_type: "text/html")
      proxy.stub("#{url}kindle-library").and_return(text: "kindle library")
    end

    it "signs in and go to the kindle library" do
      described_class.new.sign_in

      expect(KindleNotebook.session).to have_content("kindle library")
    end
  end
end
