require 'httparty'

module Paghiper
  class MissingApiKeyError < StandardError; end

  class Client
    include HTTParty

    base_uri 'https://api.paghiper.com'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    debug_output $stdout if Paghiper.configuration.http_debug

    class << self
      def create_transaction(transaction)
        peform_action!(:post, '/transaction/create', body: transaction.to_json)
      end

      private

      def prepare_options(custom_options, required_options)
        custom_options.merge!(required_options)
      end

      def peform_action!(action_name, url, options = {})
        raise(MissingTokenError, 'Informe a api key para realizar a autenticação') if Paghiper.configuration.api_key.nil? || Paghiper.configuration.api_key.empty?

        send(action_name, url, options)
      end
    end
  end
end
