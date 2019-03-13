class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.most_items(limit = 5)
    Item.joins(:invoice_items)
        .select("items.*, sum(invoice_items.quantity) AS total_sold")
        .group(:id)
        .order("total_sold DESC")
        .limit(limit)
  end
end
