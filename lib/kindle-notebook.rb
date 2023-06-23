# frozen_string_literal: true

require "capybara"
require "capybara/sessionkeeper"
require "csv"
require "selenium-webdriver"

require_relative "kindle_notebook/amazon_auth"
require_relative "kindle_notebook/book"
require_relative "kindle_notebook/client"
require_relative "kindle_notebook/configuration"
require_relative "kindle_notebook/helpers"
require_relative "kindle_notebook/highlights"
require_relative "kindle_notebook/highlight"
require_relative "kindle_notebook/version"

module KindleNotebook
  class Error < StandardError; end

  class << self
    attr_accessor :configuration, :session

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
