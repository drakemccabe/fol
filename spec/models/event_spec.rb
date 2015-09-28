require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.build :event }
  subject { event }

  it { should validate_presence_of :name }
  it { should validate_presence_of :location }
  it { should validate_presence_of :description }
  it { should validate_presence_of :image_url }
  it { should validate_presence_of :event_date }

  it { should validate_length_of(:description).is_at_most(1000) }
  it { should validate_length_of(:image_url).is_at_most(1000) }
  it { should validate_length_of(:name).is_at_most(300) }
  it { should validate_length_of(:location).is_at_most(200) }
end
