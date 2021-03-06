FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.paragraph(1, false, 1) }
    category ["fundraising", "charity", "media"].sample
    author { Faker::Name.name }
    body { Faker::Lorem.paragraph(2, false, 4) }
    image_url { Faker::Avatar.image }
    created_at { Faker::Date.backward(365) }
  end
end
