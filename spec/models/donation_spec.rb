require 'spec_helper'

describe Donation do
  let(:donation) { FactoryGirl.build :donation }
  subject { donation }

  it { should validate_presence_of :amount }
  it { should validate_presence_of :created_at }

  it { should belong_to(:contact) }
end
