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
      let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'create_with_success.json') }
      let(:return_data) { JSON.parse(File.new(file_path).read) }

      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/create').to_return(body: File.new(file_path), status: 201)
      end

      it 'returns the request response' do
        request = Paghiper::Transaction.create(@transaction)

        expect(request).to eq(return_data['create_request'])
      end
    end

    context 'with error' do
      let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'create_with_error.json') }
      let(:return_data) { JSON.parse(File.new(file_path).read) }

      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/create').to_return(body: File.new(file_path), status: 200)
      end

      it 'returns the request response' do
        request = Paghiper::Transaction.create(@transaction)

        expect(request).to eq(return_data['create_request'])
      end
    end
  end

  describe '.notification' do
    before(:all) do
      @notification = {
        apiKey: Paghiper.configuration.api_key,
        transaction_id: '3IMZI5QXGMI7K40W',
        notification_id: 'W6QM6MORZW4KUENC0NU6ERN0AULFUIUROKEU72L6ZQQT4E6521CGT0G3V2JQKDI9'
      }
    end

    context 'with success' do
      let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'notification', 'with_success.json') }
      let(:return_data) { JSON.parse(File.new(file_path).read) }

      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/notification').to_return(body: File.new(file_path), status: 201)
      end

      it 'returns the transaction information' do
        request = Paghiper::Transaction.notification(@notification)

        expect(request).to eq(return_data['status_request'])
      end
    end

    context 'with error' do
      let(:file_path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'transaction', 'notification', 'with_error.json') }
      let(:return_data) { JSON.parse(File.new(file_path).read) }

      before do
        stub_request(:post, 'https://api.paghiper.com/transaction/notification').to_return(body: File.new(file_path), status: 200)
      end

      it 'returns the request response' do
        request = Paghiper::Transaction.notification(@notification)

        expect(request).to eq(return_data['status_request'])
      end
    end
  end
end
