FactoryGirl.define do
  factory :correspondence do
    note { Faker::Lorem.paragraph }
    contact
  end
end
