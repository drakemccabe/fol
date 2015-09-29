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

  it "should have many associations" do
    t = Contact.reflect_on_association(:interests)
    t.macro.should == :has_many

    t = Contact.reflect_on_association(:correspondences)
    t.macro.should == :has_many

    t = Contact.reflect_on_association(:donations)
    t.macro.should == :has_many
  end
end
