FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { 1 }
    credit_card_expiration_date { "2019-03-12" }
    result { "success" }
  end
end
