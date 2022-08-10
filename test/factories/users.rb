FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user_##{n}" }
    sequence(:password) { |n| "pass_##{n}" }
    deposit { 10 }
  end

  factory :buyer_user, traits: [:buyer]
  factory :seller_user, traits: [:seller]
end
