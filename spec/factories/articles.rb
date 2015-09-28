FactoryGirl.define do
  factory :article do
    category ["fundraising", "charity", "media"].sample
    author { Faker::Name.name }
    body { Faker::Lorem.paragraph(2, false, 4) }
    image_url "http://drakemccabe.com/assets/img/write1.jpg"
    created_at { Faker::Date.backward(365) }
  end
end
