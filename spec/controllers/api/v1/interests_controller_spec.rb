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

  describe "POST #create" do
    context "when a new interest is saved" do
      before(:each) do
        user = FactoryGirl.create :user
        @interest_attributes = FactoryGirl.attributes_for :interest
        api_authorization_header user.auth_token
        post :create, { interest: @interest_attributes }
      end

      it "returns the interest just created" do
        interest_response = json_response
        expect(interest_response[:interest]).to eql @interest_attributes[:interest]
      end

      it { should respond_with 201 }
    end

    context "when interest fails to save" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_interest_attributes = { interest: "two" * 100 }
        api_authorization_header user.auth_token
        post :create, { interest: @invalid_interest_attributes }
      end

      it "renders errors" do
        interest_response = json_response
        expect(interest_response).to have_key(:errors)
      end

      it "returns full error messages" do
        interest_response = json_response
        expect(interest_response[:errors][:interest]).to include "is too long (maximum is 200 characters"
      end

      it { should respond_with 422 }
    end
  end
end
