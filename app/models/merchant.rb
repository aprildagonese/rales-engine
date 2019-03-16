class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(limit = 5)
    Merchant.joins(invoices: [:invoice_items, :transactions])
        .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
        .group(:id)
        .merge(Transaction.successful)
        .order("total_revenue DESC")
        .limit(limit)
  end

  def self.most_items(limit = 5)
    Merchant.joins(invoices: [:invoice_items, :transactions])
        .select("merchants.*, sum(invoice_items.quantity) AS total_sold")
        .group(:id)
        .merge(Transaction.successful)
        .order("total_sold DESC")
        .limit(limit)
  end

  def revenue
    self.invoice_items.joins(invoice: :transactions)
        .select("sum(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
        .merge(Transaction.successful)[0]
        .total_revenue
  end

  def revenue_by_date(date)
    self.invoice_items.joins(invoice: :transactions)
        .select("sum(invoice_items.quantity*invoice_items.unit_price) AS days_revenue")
        .where(created_at: date.all_day)
        .merge(Transaction.successful)[0]
        .days_revenue
  end
end
