class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  has_many :transactions
  belongs_to :customer

  def self.most_revenue(limit = 5)
    Invoice.select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
           .joins(:invoice_items, :transactions)
           .group(:id)
           .where(transactions: {result: "success"})
           .order("revenue DESC")
           .limit(5)
  end

  def self.revenue(date)
    x = Invoice.joins(:invoice_items, :transactions)
        .select("invoices.created_at, sum(invoice_items.quantity*invoice_items.unit_price) AS days_revenue")
        .group(:id)
        .where(created_at: date.all_day)
        .merge(Transaction.successful)
        .first
        .days_revenue
  end
end
