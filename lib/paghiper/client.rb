require 'httparty'

module Paghiper
  class MissingApiKeyError < StandardError; end
  class MissingTokenError < StandardError; end

  class Client
    include HTTParty

    base_uri 'https://api.paghiper.com'
    headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
    debug_output $stdout if Paghiper.configuration && Paghiper.configuration.http_debug

    class << self
      def create_transaction(data)
        peform_action!(:post, '/transaction/create', body: prepare_body(data))
      end

      def transaction_notification(data)
        raise(MissingTokenError, 'Informe o token para realizar essa operação') if missing_configuration_parameter?(:token)

        peform_action!(:post, '/transaction/notification', body: data.merge(token: Paghiper.configuration.token).to_json)
      end

      private

      def missing_configuration_parameter?(parameter)
        return Paghiper.configuration.nil? || Paghiper.configuration.send(parameter).nil? || Paghiper.configuration.send(parameter).empty?
      end

      def prepare_body(data)
        data.merge(apiKey: Paghiper.configuration.api_key).to_json
      end

      def peform_action!(action_name, url, options = {})
        raise(MissingApiKeyError, 'Informe a api key para realizar a autenticação') if missing_configuration_parameter?(:api_key)

        parse_response(send(action_name, url, options))
      end

      def parse_response(response)
        JSON.parse(response.body).with_indifferent_access
      end
    end
  end
end
