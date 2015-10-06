require 'spec_helper'

describe Api::V1::InterestsController do
  describe "GET #show" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      @interest = FactoryGirl.create :interest
      get :show, id: @interest.id
    end

    it "returns a single interest object" do
      interest_response = json_response
      expect(interest_response[:interest]).to eql @interest.interest
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      2.times { FactoryGirl.create :interest }
      get :index
    end

    it "returns 2 interests" do
      interests_response = json_response
      expect(interests_response[:interests].size).to eql(2)
    end

    it { should respond_with 200 }
  end
end
