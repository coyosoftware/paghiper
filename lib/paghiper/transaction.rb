module Paghiper
  class Transaction
    class << self
      def create(transaction)
        response = Paghiper::Client.create_transaction(transaction)
        hash = JSON.parse(response.body).with_indifferent_access

        return hash['create_request']
      end
    end
  end
end
