require 'rails_helper'

RSpec.describe BulkInsertContractWorker, type: :worker do
  let!(:csv_text) do
    "email,name,address,price,start_date,end_date,expiry_date\n"\
    'pcofilada@gmail.com,Patrick Ofilada,Philippines,100,May 25 2021,May 30 2021,January 1 2022'
  end

  it 'should respond to #perform' do
    expect(BulkInsertContractWorker.new).to respond_to(:perform)
  end

  it 'enqueues a new job' do
    expect {
      BulkInsertContractWorker.perform_async(csv_text)
    }.to change(BulkInsertContractWorker.jobs, :size).by(1)
  end
end
