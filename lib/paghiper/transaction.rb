module Paghiper
  class Transaction
    class << self
      def create(transaction)
        response = Paghiper::Client.create_transaction(transaction)

        return response['create_request']
      end

      def notification(notification)
        response = Paghiper::Client.transaction_notification(notification)

        return response['status_request']
      end
    end
  end
end
