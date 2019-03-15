class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(limit = 5)
    self.joins(items: :invoice_items, invoices: :transactions)
        .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
        .group(:id)
        .merge(Transaction.successful)
        .order("total_revenue DESC")
        .limit(limit)
  end

  def self.most_items(limit = 5)
    self.joins(items: :invoice_items, invoices: :transactions)
        .select("merchants.*, sum(invoice_items.quantity) AS total_sold")
        .group(:id)
        .merge(Transaction.successful)
        .order("total_sold DESC")
        .limit(limit)
  end
end
