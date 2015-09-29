FactoryGirl.define do
  factory :interest do
    interest { Interest::INTERESTS.sample }
    contact
  end
end
