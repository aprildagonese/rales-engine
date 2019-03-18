class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  # scope :successful, -> { where(result: "success")}

  def self.most_items(limit = 5)
    Item.joins(:invoice_items)
        .select("items.*, sum(invoice_items.quantity) AS total_sold")
        .group(:id)
        .order("total_sold DESC")
        .limit(limit)
  end

  def self.most_revenue(limit = 5)
    Item.joins(:invoice_items)
        .select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS item_revenue")
        .group(:id)
        .order("item_revenue DESC")
        .limit(limit)
  end

  def best_day
    x = Invoice.joins(:invoice_items, :transactions)
           .select("invoices.created_at, sum(invoice_items.quantity) AS most_sold")
           .group("invoices.created_at")
           .where(invoice_items: {item_id: self.id})
           .merge(Transaction.successful)
           .order("most_sold DESC, created_at DESC")[0]
           .created_at
  end

end
