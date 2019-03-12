FactoryBot.define do
  factory :transaction do
    credit_card_number { 1 }
    credit_card_expiration_date { "2019-03-12" }
    result { "MyString" }
    created_at { "MyDate" }
    updated_at { "MyDate" }
  end
end
