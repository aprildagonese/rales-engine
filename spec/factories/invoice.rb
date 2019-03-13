FactoryBot.define do
  factory :invoice do
    association :merchant, :customer
    status { "MyString" }
  end
end
