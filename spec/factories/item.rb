FactoryBot.define do
  factory :item do
    association :merchant
    sequence(:name) { |n| "Item#{n}" }
    sequence(:description) { |n| "Item#{n} Description" }
    unit_price { "9.99" }
  end
end
