require 'rails_helper'

RSpec.describe '/customers', type: :request do
  let(:valid_params) do
    { name: Faker::Name.name, address: Faker::Address.full_address, email: Faker::Internet.email }
  end
  let(:invalid_params) { { name: nil, address: nil, email: nil } }
  let(:valid_headers) { {} }

  describe 'GET /index' do
    it 'renders a successful response' do
      Customer.create!(valid_params)
      get customers_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      customer = Customer.create!(valid_params)
      get customer_url(customer), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      it 'create a new Customer' do
        expect {
          post customers_url,
               params: { customer: valid_params }, headers: valid_headers, as: :json
        }.to change(Customer, :count).by(1)
      end

      it 'renders a JSON response with the new customer' do
        post customers_url,
             params: { customer: valid_params }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Customer' do
        expect {
          post customers_url,
               params: { customer: invalid_params }, as: :json
        }.to change(Customer, :count).by(0)
      end

      it 'renders a JSON response with errors for the new customer' do
        post customers_url,
             params: { customer: invalid_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid params' do
      let(:new_params) do
        { 'name' => Faker::Name.name, 'address' => Faker::Address.full_address, 'email' => Faker::Internet.email }
      end

      it 'updates the customer' do
        customer = Customer.create!(valid_params)
        patch customer_url(customer),
              params: { customer: new_params }, headers: valid_headers, as: :json
        customer.reload
        expect(customer.attributes.slice('name', 'address', 'email')).to eq(new_params)
      end

      it 'renders a JSON response with the customer' do
        customer = Customer.create!(valid_params)
        patch customer_url(customer),
              params: { customer: new_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the customer' do
        customer = Customer.create!(valid_params)
        patch customer_url(customer),
              params: { customer: invalid_params }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested customer' do
      customer = Customer.create!(valid_params)
      expect {
        delete customer_url(customer), headers: valid_headers, as: :json
      }.to change(Customer, :count).by(-1)
    end
  end
end
