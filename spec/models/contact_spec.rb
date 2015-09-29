require 'spec_helper'

describe Contact do
  let(:contact) { FactoryGirl.build :contact }
  subject { contact }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :address }

  it { should validate_length_of(:first_name).is_at_most(200) }
  it { should validate_length_of(:last_name).is_at_most(200) }
  it { should validate_length_of(:address).is_at_most(200) }
  it { should validate_length_of(:zip).is_at_most(16) }
  it { should validate_length_of(:phone).is_at_most(16) }
  it { should validate_length_of(:city).is_at_most(100) }
  it { should validate_length_of(:email).is_at_most(100) }
  it { should validate_length_of(:state).is_equal_to(2) }

  it { should validate_uniqueness_of(:address) }

  it { should_have_many(:memberships) }
  it { should_have_many(:interests) }
  it { should_have_many(:donations) }
  it { should_have_many(:correspondences) }
end
