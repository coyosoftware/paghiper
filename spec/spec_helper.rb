require 'bundler/setup'
require 'paghiper'
require 'webmock/rspec'
require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    Paghiper.configure do |configuration|
      configuration.api_key = 'FOOBAR'
      configuration.token = 'BARFOO'
    end
  end
end
