class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

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
    Merchant.joins(invoices: [:invoice_items, :transactions])
        .select("sum(invoice_items.quantity*invoice_items.unit_price) AS days_revenue")
        .where(id: self.id)
        .where(invoices: {created_at: date.all_day})
        .merge(Transaction.successful)[0]
        .days_revenue
  end

  def favorite_customer
    Customer.joins(invoices: :transactions)
            .select("customers.*, count(transactions.id) AS transaction_count")
            .group(:id)
            .merge(Transaction.successful)
            .where(invoices: {merchant_id: self.id})
            .order("transaction_count DESC")[0]
  end

  def customers_with_pending_invoices
    successful_invoices = Invoice.joins(:transactions)
        .merge(Transaction.successful)
        .where(merchant_id: self.id)

    Customer.joins(:invoices)
            .where.not(invoices: {id: successful_invoices})
            .where(invoices: {merchant_id: self.id})
            .order(:id)
            .distinct
  end
end
