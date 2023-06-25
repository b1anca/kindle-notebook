# frozen_string_literal: true

RSpec.describe KindleNotebook do
  it "has a version number" do
    expect(KindleNotebook::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:url) { "https://read.amazon.com/" }
    let(:login) { "username" }
    let(:password) { "42password" }
    let(:selenium_driver) { :chrome }
    let(:headless_mode) { false }
    let(:min_highlight_words) { 2 }
    let(:max_highlight_words) { 10 }

    before do
      described_class.configure do |config|
        config.url = url
        config.login = login
        config.password = password
        config.selenium_driver = selenium_driver
        config.headless_mode = headless_mode
        config.min_highlight_words = min_highlight_words
        config.max_highlight_words = max_highlight_words
      end
    end

    it "returns the config" do
      expect(described_class.configuration.url).to eq(url)
      expect(described_class.configuration.login).to eq(login)
      expect(described_class.configuration.password).to eq(password)
      expect(described_class.configuration.selenium_driver).to eq(selenium_driver)
      expect(described_class.configuration.headless_mode).to eq(headless_mode)
      expect(described_class.configuration.min_highlight_words).to eq(min_highlight_words)
      expect(described_class.configuration.max_highlight_words).to eq(max_highlight_words)
    end
  end
end
