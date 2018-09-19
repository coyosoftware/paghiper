require 'spec_helper'

RSpec.describe Paghiper::Client do
  describe '.create_transaction' do
    let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'create_with_success.json') }

    before(:all) do
      @transaction = {
        order_id: '32330335',
        payer_email: 'poulsilva@exemple.com',
        payer_name: 'Poul Silva',
        payer_cpf_cnpj: '00000000191',
        payer_phone: '1140638785',
        payer_street: 'Av Brigadeiro Faria Lima',
        payer_number: '1461',
        payer_complement: 'Torre Sul 4º Andar',
        payer_district: 'Jardim Paulistano',
        payer_city: 'São Paulo',
        payer_state: 'SP',
        payer_zip_code: '01452002',
        notification_url: 'https://mysite.com/notify/paghiper/',
        discount_cents: '1100',
        shipping_price_cents: '2595',
        shipping_methods: 'PAC',
        fixed_description: true,
        days_due_date: '5',
        type_bank_slip: 'boletoA4',
        items: [{ description: 'piscina de bolinha', quantity: '1', item_id: '1', price_cents: '1012' }]
      }
    end

    it 'issues a POST to the transaction endpoint with the apiKey' do
      stub = stub_request(:post, 'https://api.paghiper.com/transaction/create').with(body: @transaction.merge(apiKey: Paghiper.configuration.api_key).to_json)
        .to_return(body: File.new(file_path), status: 201)

      described_class.create_transaction(@transaction)

      expect(stub).to have_been_requested
    end
  end

  describe '.transaction_notification' do
    let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'notification', 'with_success.json') }

    before(:all) do
      @notification = {
        apiKey: Paghiper.configuration.api_key,
        transaction_id: 'BPV661O7AVLORCN5',
        notification_id: 'W6QM6MORZW4KUENC0NU6ERN0AULFUIUROKEU72L6ZQQT4E6521CGT0G3V2JQKDI9'
      }
    end

    it 'issues a POST to the transaction notification endpoint with the token' do
      stub = stub_request(:post, 'https://api.paghiper.com/transaction/notification').with(body: @notification.merge(token: Paghiper.configuration.token).to_json)
        .to_return(body: File.new(file_path), status: 201)

      described_class.transaction_notification(@notification)

      expect(stub).to have_been_requested
    end
  end
end
