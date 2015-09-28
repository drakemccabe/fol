require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.build :article }
  subject { article }

  it { should validate_presence_of :title }
  it { should validate_presence_of :category }
  it { should validate_presence_of :author }
  it { should validate_presence_of :body }
  it { should validate_presence_of :image_url }

  it { should validate_length_of(:image_url).is_at_most(1000) }
  it { should validate_length_of(:category).is_at_most(300) }
  it { should validate_length_of(:author).is_at_most(300) }
  it { should validate_length_of(:title).is_at_least(4).is_at_most(500) }
end
