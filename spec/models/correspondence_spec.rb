require 'spec_helper'

describe Correspondence do
  let(:correspondence) { FactoryGirl.build :correspondence }
  subject { correspondence }

  it { should validate_presence_of :note }
  it { should validate_length_of(:note).is_at_most(1000) }
  it { should belong_to(:contact) }
end
