require 'rails_helper'

RSpec.describe Contract, type: :model do
  let!(:contract) { build(:contract) }

  describe 'validations' do
    describe 'price' do
      context 'if present' do
        it { expect(contract).to be_valid }
      end

      context 'if not present' do
        it do
          contract.price = nil

          expect(contract).not_to be_valid
        end
      end
    end

    describe 'start_date' do
      context 'if present' do
        it { expect(contract).to be_valid }
      end

      context 'if not present' do
        it do
          contract.start_date = nil

          expect(contract).not_to be_valid
        end
      end
    end

    describe 'end_date' do
      context 'if present' do
        it { expect(contract).to be_valid }
      end

      context 'if not present' do
        it do
          contract.end_date = nil

          expect(contract).not_to be_valid
        end
      end
    end

    describe 'expiry_date' do
      context 'if present' do
        it { expect(contract).to be_valid }
      end

      context 'if not present' do
        it do
          contract.expiry_date = nil

          expect(contract).not_to be_valid
        end
      end
    end
  end

  describe 'associations' do
    it 'belongs_to customer' do
      assc = described_class.reflect_on_association(:customer)

      expect(assc.class).to eq(Mongoid::Association::Referenced::BelongsTo)
    end
  end
end
