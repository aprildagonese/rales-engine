require 'csv'

namespace :import do
  task merchants: :environment do
    CSV.foreach('lib/csv/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
  end
  task items: :environment do
    CSV.foreach('lib/csv/items.csv', :headers => true) do |row|
      Item.create!(row.to_hash)
    end
  end
  task customers: :environment do
    CSV.foreach('lib/csv/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
  end
  task invoices: :environment do
    CSV.foreach('lib/csv/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
  end
  task invoice_items: :environment do
    CSV.foreach('lib/csv/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
  task transactions: :environment do
    CSV.foreach('lib/csv/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
