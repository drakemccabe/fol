require 'spec_helper'

describe Membership do
  let(:membership) { FactoryGirl.build :membership }
  subject { membership }

  it { should belong_to :contact }
end
