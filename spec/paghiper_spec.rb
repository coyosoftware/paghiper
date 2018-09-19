require 'spec_helper'

RSpec.describe Paghiper do
  it 'has a version number' do
    expect(Paghiper::VERSION).not_to be nil
  end

  it 'allows to use the config method to configure the core class' do
    Paghiper.configure do |config|
      config.api_key = 'BAR123'
      config.token = 'FOO321'
    end

    expect(Paghiper.configuration.api_key).to eq('BAR123')
    expect(Paghiper.configuration.token).to eq('FOO321')
  end
end
