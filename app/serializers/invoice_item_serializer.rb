class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :invoice_id, :item_id
  attribute :unit_price do |object|
    '%.2f' % (object.unit_price / 100.0)
  end
end
