require 'spec_helper'

RSpec.describe Paghiper::Client do
  describe '.create_transaction' do
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
      stub_request(:post, 'https://api.paghiper.com/transaction/create').with(body: @transaction.merge(apiKey: Paghiper.configuration.api_key).to_json)

      described_class.create_transaction(@transaction)
    end
  end
end
