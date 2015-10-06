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
end
