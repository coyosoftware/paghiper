require 'spec_helper'

RSpec.describe Paghiper::Transaction do
  describe '.create' do
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

    context 'with success' do
      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/create').to_return(body: File.new(File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'create_with_success.json')), status: 201)
      end

      it 'creates a new transaction' do
        request = Paghiper::Transaction.create(@transaction)

        expect(request[:result]).to eq('success')
        expect(request[:transaction_id]).to eq('HF97T5SH2ZQNLF6Z')
        expect(request[:http_code]).to eq('201')
      end
    end

    context 'with error' do
      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/create').to_return(body: File.new(File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'create_with_error.json')), status: 200)
      end

      it 'does not create a new transaction' do
        request = Paghiper::Transaction.create(@transaction)

        expect(request[:result]).to eq('reject')
        expect(request[:response_message]).to eq('foo bar')
        expect(request[:http_code]).to eq('200')
      end
    end
  end
end
