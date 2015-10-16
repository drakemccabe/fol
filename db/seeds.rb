require "faker"

200.times do
  Contact.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 address: Faker::Address.street_address,
                 city: Faker::Address.city,
                 state: Faker::Address.state_abbr,
                 zip: Faker::Address.zip,
                 phone: "5084685051",
                 email: Faker::Internet.email,
                 is_business: [true, false].sample,
                 is_family: [true, false].sample,
                 is_resident: [true, false].sample,
                 latitude: 42.0 + rand(0.05),
                 longitude: -71.0 - rand(0.05))

  contact_id = Contact.all.last.id

  (0..10).to_a.sample.times do
    Correspondence.create(note: Faker::Lorem.paragraph,
                          contact_id: contact_id)
  end

  (0..10).to_a.sample.times do
    Donation.create(amount: rand(5.0..500.0).round(2),
                    created_at: Faker::Date.backward(200),
                    contact_id: contact_id)
  end

  (0..10).to_a.sample.times do
    Interest.create(interest: Interest::INTERESTS.sample,
                    contact_id: contact_id)
  end

  date = Contact.find(contact_id).donations.last.try(:date_filed)
  expire = date + 365 unless date.nil?

  Membership.create(status: [true, false].sample,
                lifetime: [true, false].sample,
                expiration_date: expire,
                contact_id: contact_id)

  print "."
end

20.times do

  Article.create(title: Faker::Lorem.sentence,
                 category: ["fundraising", "charity", "media"].sample,
                 author: Faker::Name.name,
                 body: Faker::Lorem.paragraph(2, false, 4),
                 image_url: "http://lorempixel.com/400/200/",
                 created_at: Faker::Date.backward(365))

  Event.create(name: Faker::Lorem.sentence,
               location: Faker::Address.street_address,
               description: Faker::Lorem.paragraph(1),
               image_url: "http://lorempixel.com/400/200/",
               event_date: Faker::Time.between(DateTime.now + 10, DateTime.now))

  print "."
end
