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
        @invalid_interest_attributes = { interest: "waterslides" }
        api_authorization_header user.auth_token
        post :create, { interest: @invalid_interest_attributes }
      end

      it "renders errors" do
        interest_response = json_response
        expect(interest_response).to have_key(:errors)
      end

      it "returns full error messages" do
        interest_response = json_response
        expect(interest_response[:errors][:interest]).to include "is not included in the list"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @interest = FactoryGirl.create :interest
      api_authorization_header @user.auth_token
    end

    context "when interest is successfully created" do
      before(:each) do
        patch :update, { id: @interest.id,
              interest: { interest: "cultural events" } }
      end

      it "it returns the created interest" do
        interest_response = json_response
        expect(interest_response[:interest]).to eql "cultural events"
      end

      it { should respond_with 200 }
    end

    context "when an interest fails to update" do
      before(:each) do
        patch :update, { id: @interest.id,
              interest: { interest: "skydiving" } }
      end

      it "returns errors" do
        interest_response = json_response
        expect(interest_response).to have_key(:errors)
      end

      it "returns full error messages" do
        interest_response = json_response
        expect(interest_response[:errors][:interest]).to include "is not included in the list"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @interest = FactoryGirl.create :interest
      api_authorization_header @user.auth_token
      delete :destroy, { id: @interest.id }
    end

    it { should respond_with 204 }
  end
end
