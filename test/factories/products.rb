FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "product_##{n}" }
    amount_available { 10 }
    price { 5 }
    association :seller, factory: [:user, :seller]
  end
end
