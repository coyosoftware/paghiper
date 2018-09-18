require 'httparty'

module Paghiper
  class MissingApiKeyError < StandardError; end

  class Client
    include HTTParty

    base_uri 'https://api.paghiper.com'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    debug_output $stdout if Paghiper.configuration && Paghiper.configuration.http_debug

    class << self
      def create_transaction(transaction)
        peform_action!(:post, '/transaction/create', body: prepare_body(transaction))
      end

      private

      def prepare_body(data)
        data.merge(apiKey: Paghiper.configuration.api_key).to_json
      end

      def peform_action!(action_name, url, options = {})
        raise(MissingTokenError, 'Informe a api key para realizar a autenticação') if Paghiper.configuration.api_key.nil? || Paghiper.configuration.api_key.empty?

        send(action_name, url, options)
      end
    end
  end
end
