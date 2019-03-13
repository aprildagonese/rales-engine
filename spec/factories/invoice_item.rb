FactoryBot.define do
  factory :invoice_item do
    association :item, :invoice
    quantity { 1 }
    unit_price { "9.99" }
  end
end
