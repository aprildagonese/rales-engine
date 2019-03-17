class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :credit_card_number, :invoice_id, :result
end
