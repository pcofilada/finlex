require 'rails_helper'

RSpec.describe "/contracts", type: :request do
  let!(:customer) { create(:customer) }
  let(:valid_params) do
    {
      price: Faker::Number.decimal(l_digits: 2),
      start_date: Faker::Date.forward(days: 1),
      end_date: Faker::Date.forward(days: 15),
      expiry_date: Faker::Date.forward(days: 30),
      customer_id: customer.id
    }
  end
  let(:invalid_params) { { price: nil, start_date: nil, end_date: nil, expiry_date: nil } }
  let(:valid_headers) { {} }

  describe 'GET /index' do
    it 'renders a successful response' do
      Contract.create!(valid_params)
      get customer_contracts_url(customer), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      contract = Contract.create!(valid_params)
      get customer_contract_url(customer, contract), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'creates a new Contract' do
        expect {
          post customer_contracts_url(customer),
               params: { contract: valid_params }, headers: valid_headers, as: :json
        }.to change(Contract, :count).by(1)
      end

      it 'renders a JSON response with the new contract' do
        post customer_contracts_url(customer),
             params: { contract: valid_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Contract' do
        expect {
          post customer_contracts_url(customer), 
               params: { contract: invalid_params }, headers: valid_headers, as: :json
        }.to change(Contract, :count).by(0)
      end

      it 'renders a JSON response with errors for the new contract' do
        post customer_contracts_url(customer),
             params: { contract: invalid_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid params' do
      let(:new_params) do
        {
          'price' => "100",
        }
      end

      it 'updates the requested contract' do
        contract = Contract.create!(valid_params)
        patch customer_contract_url(customer, contract),
              params: { contract: new_params }, headers: valid_headers, as: :json
        contract.reload
        expect(contract.attributes.slice('price')).to eq(new_params)
      end

      it 'renders a JSON response with the contact' do
        contract = Contract.create!(valid_params)
        patch customer_contract_url(customer, contract),
              params: { contract: new_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the contract' do
        contract = Contract.create!(valid_params)
        patch customer_contract_url(customer, contract),
              params: { contract: invalid_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested contract' do
      contract = Contract.create!(valid_params)
      expect {
        delete customer_contract_url(customer, contract), headers: valid_headers, as: :json
      }.to change(Contract, :count).by(-1)
    end
  end

  describe 'POST /import_contracts' do
    let(:csv_file) { fixture_file_upload(file_fixture('sample_contracts.csv'), 'text/csv') }
    let(:doc_file) { fixture_file_upload(file_fixture('invalid_contracts.docs'), 'text/docs') }

    context 'with a valid csv file format' do
      it 'renders json with success message' do
        post import_contracts_url,
             params: { file: csv_file }, headers: valid_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid file format' do
      it 'renders json with error message' do
        post import_contracts_url,
             params: { file: doc_file }, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
