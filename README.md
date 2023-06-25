# Kindle Notebook

Fetch your Kindle Highlights along with their context using the Selenium Webdriver

[![Gem Version](https://badge.fury.io/rb/kindle-notebook.svg)](https://badge.fury.io/rb/kindle-notebook)

## Installation

Install the gem and add to the application's Gemfile by executing:

```sh
$ bundle add kindle-notebook
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
$ gem install kindle-notebook
```

## Configuration

You can either create a `.env` file and add your credentials, the default values will be fetched from this file, or configure the gem, for example in an initializer file.

```rb
KindleNotebook.configure do |config|
  config.url = "https://read.amazon.com/"
  config.login = ENV["AMAZON_EMAIL"]
  config.password = ENV["AMAZON_PASSWORD"]
  config.selenium_driver = :firefox
  config.headless_mode = false
  config.min_highlight_words = 1
  config.max_highlight_words = 3
end
```

The configuration options `min_highlight_words` and `max_highlight_words` control the range of word count for the highlights.

## Usage

Sign in:
```rb
client = KindleNotebook::Client.new
client.sign_in
```

Get the highlights from a book:
```rb
books = client.books
book = books.first
book.fetch_highlights
book.highlights
```

To write to a CSV file:
```rb
book.to_csv_file # => "Docker: A Project-Based Approach to Learning - Cannon, Jason.csv"
```

## Examples

Book:
```rb
#<KindleNotebook::Book:0x00007f0847c4e388
  @asin="B09FJ3411G",
  @author="Cannon, Jason",
  @highlights=[#<KindleNotebook::Highlight:0x00007f46959d61f0 @book_asin="B09FJ3411G", ...],
  @highlights_count=13,
  @title="Docker: A Project-Based Approach to Learning">
```

<!-- TODO: create highligh class -->
Highlight:
```rb
#<KindleNotebook::Highlight:0x00007f46959d61f0
  @book_asin="B09FJ3411G",
  @context="If you get stuck, the logging component of systemd, called journald, can also help.",
  @page="120",
  @raw_context="used, for example. If you get stuck, the logging component of systemd, called journald, can also help. This journald command displays the last 20 entries in the",
  @raw_text="journald,",
  @text="journald">
```

Book CSV:
```csv
text,page,context,book_asin,raw_text,raw_context
journald,120,"If you get stuck, the logging component of systemd, called journald, can also help.",B09FJ3411G,"journald,","used, for example. If you get stuck, the logging component of systemd, called journald, can also help. This journald command displays the last 20 entries in the"
swarm,225,"Docker Swarm In this chapter, you're going to learn how to create and use a Docker",B09FJ3411G,swarm.,"Docker Swarm In this chapter, you're going to learn how to create and use a Docker"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Testing

This gem is using [puffing-billy](https://github.com/oesmith/puffing-billy) for testing which needs the geckodriver executable.  It can be installed with:
```sh
$ sudo apt-get install firefox-geckodriver # or
$ brew install geckodriver
```

The executable should be in your `PATH`, if it is not you can run the following command (please adapt the location of the geckodriver executable with yours):
```sh
$ echo 'export PATH=$PATH:/home/user/.cache/selenium/geckodriver/linux64/0.33.0' >> ~/.zshrc
 ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/b1anca/kindle-notebook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/b1anca/kindle-notebook/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the KindleNotebook project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/b1anca/kindle-notebook/blob/main/CODE_OF_CONDUCT.md).
