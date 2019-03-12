FactoryBot.define do
  factory :invoice_item do
    association :item, :invoice
    quantity { 1 }
    unit_price { "9.99" }
    created_at { "MyDate" }
    updated_at { "MyDate" }
  end
end
