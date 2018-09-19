require 'paghiper/version'
require 'active_support/core_ext/hash/indifferent_access'

module Paghiper
  autoload :Transaction, 'paghiper/transaction'
  autoload :Client, 'paghiper/client'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new

    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key, :token, :http_debug

    def initialize
      @http_debug = false
    end
  end
end
