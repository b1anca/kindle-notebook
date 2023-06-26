# frozen_string_literal: true

require "kindle-notebook"
require "pry"
require "billy/capybara/rspec"

RSpec.configure do |config|
  config.filter_run_when_matching :focus

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    KindleNotebook.configure do |c|
      c.url = "http://www.mockedkindlereadurl.com/"
      c.login = "username"
      c.password = "42password"
      c.selenium_driver = :selenium_billy
      c.headless_mode = true
      c.min_highlight_words = 1
      c.max_highlight_words = 3
    end
  end
end
