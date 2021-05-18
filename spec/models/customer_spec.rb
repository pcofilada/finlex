require 'rails_helper'

RSpec.describe Customer, type: :model do
  let!(:customer) { build(:customer) }

  describe 'validations' do
    describe 'name' do
      context 'if present' do
        it { expect(customer).to be_valid }
      end

      context 'if not present' do
        it do
          customer.name = nil

          expect(customer).not_to be_valid
        end
      end
    end

    describe 'address' do
      context 'if present' do
        it { expect(customer).to be_valid }
      end

      context 'if not present' do
        it do
          customer.address = nil

          expect(customer).not_to be_valid
        end
      end
    end

    describe 'email' do
      context 'if present' do
        it { expect(customer).to be_valid }
      end

      context 'if not present' do
        it do
          customer.email = nil

          expect(customer).not_to be_valid
        end
      end

      context 'if unique' do
        it do
          customer_clone = build(:customer, email: Faker::Internet.email)

          expect(customer_clone).to be_valid
        end
      end

      context 'if not unique' do
        it do
          customer.save
          customer_clone = build(:customer, email: customer.email)

          expect(customer_clone).not_to be_valid
        end
      end
    end
  end
end
