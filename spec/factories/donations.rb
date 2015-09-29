FactoryGirl.define do
  factory :donation do
    amount { Faker::Commerce.price }
    created_at { Faker::Date.backward(200) }
    contact
  end
end
