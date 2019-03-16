class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merch_id = self.transactions
                   .select("invoices.merchant_id, count(transactions.id) AS transaction_count")
                   .group("invoices.merchant_id")
                   .where(transactions: {result: "success"})
                   .order("transaction_count DESC")
                   .limit(1)
                   .first
                   .merchant_id
    Merchant.find(merch_id)
  end
end
