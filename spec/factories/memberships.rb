FactoryGirl.define do
  factory :membership do
    status [true, false].sample
    lifetime [true, false].sample
    contact
  end
end
