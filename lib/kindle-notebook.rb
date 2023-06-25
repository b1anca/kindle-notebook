# frozen_string_literal: true

require "capybara"
require "capybara/sessionkeeper"
require "csv"
require "selenium-webdriver"
require "dotenv"

require_relative "kindle_notebook/amazon_auth"
require_relative "kindle_notebook/book"
require_relative "kindle_notebook/client"
require_relative "kindle_notebook/configuration"
require_relative "kindle_notebook/helpers"
require_relative "kindle_notebook/highlights"
require_relative "kindle_notebook/highlight"
require_relative "kindle_notebook/version"

Dotenv.load

module KindleNotebook
  class Error < StandardError; end

  class Configuration
    attr_accessor :url, :login, :password, :selenium_driver, :headless_mode, :min_highlight_words,
                  :max_highlight_words

    def initialize
      @url = ENV["KINDLE_READER_URL"]
      @login = ENV["AMAZON_EMAIL"]
      @password = ENV["AMAZON_PASSWORD"]
      @selenium_driver = ENV["SELENIUM_DRIVER"]
      @headless_mode = ENV["HEADLESS_MODE"] == "true"
      @min_highlight_words = ENV["MIN_HIGHLIGHT_WORDS"].to_i
      @max_highlight_words = ENV["MAX_HIGHLIGHT_WORDS"].to_i
    end
  end

  class << self
    attr_writer :configuration
    attr_accessor :session
  end

  def self.configuration
    @configuration ||= KindleNotebook::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
