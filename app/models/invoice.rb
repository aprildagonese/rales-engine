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

  def self.revenue_by_date(date)
    Invoice.joins(:invoice_items, :transactions)
        .select("sum(invoice_items.quantity*invoice_items.unit_price) AS days_revenue")
        .where(created_at: date.all_day)
        .merge(Transaction.successful)[0]
        .days_revenue
  end
end
