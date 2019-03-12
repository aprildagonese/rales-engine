FactoryBot.define do
  factory :item do
    merchant
    name { "MyString" }
    description { "MyString" }
    unit_price { "9.99" }
    created_at { "MyDate" }
    updated_at { "MyDate" }
  end
end
