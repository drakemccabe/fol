FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    phone "6175555555"
    email { Faker::Internet.email }
    is_business [true, false].sample
    is_family [true, false].sample
    is_resident [true, false].sample
  end
end
