FactoryGirl.define do
  factory :event do
    name { Faker::Lorem.sentence }
    location { Faker::Address.street_address }
    description { Faker::Lorem.paragraph(1) }
    image_url "http://drakemccabe.com/assets/img/write1.jpg"
    event_date { Faker::Date.forward(365) }
  end
end
