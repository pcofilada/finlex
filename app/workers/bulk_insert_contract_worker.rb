class BulkInsertContractWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(csv_text)
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |item|
      customer = Customer.create_with(name: item[1], address: item[2])
                         .find_or_create_by(email: item[0])
      customer.contracts
              .create!(price: item[3], start_date: item[4], end_date: item[5], expiry_date: item[6])
    end
  end
end
