require 'spec_helper'

describe Api::V1::DonationsController do
  describe "GET #show" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      @donation = FactoryGirl.create :donation
      get :show, id: @donation.id
    end

    it "returns json info on a single donation" do
      donation_response = json_response
      expect(donation_response[:donation][:amount]).to eql @donation.amount
      expect(donation_response[:donation][:contact_id]).to eql @donation.contact_id
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      20.times { FactoryGirl.create :donation }
      get :index
    end

    it "returns 20 records from the donations table" do
      donations_response = json_response
      expect(donations_response[:donations].size).to eq(20)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when a new donation is created" do
      before(:each) do
        user = FactoryGirl.create :user
        contact = FactoryGirl.create :contact
        api_authorization_header user.auth_token
        @donation_attributes = FactoryGirl.attributes_for :donation
        @donation_attributes[:contact_id] = contact.id
        post :create, { donation: @donation_attributes }
      end

      it "returns the donation just created in json" do
        donation_response = json_response
        expect(donation_response[:donation][:amount]).to eql @donation_attributes[:amount]
      end

      it { should respond_with 201 }
    end

    context "when a new donation is NOT created" do
      before(:each) do
        user = FactoryGirl.create :user
        @bad_donation_attributes = { amount: 0, contact_id: 0 }
        api_authorization_header user.auth_token
        post :create, { donation: @bad_donation_attributes }
      end

      it "returns errors in JSON" do
        donation_response = json_response
        expect(donation_response).to have_key(:errors)
      end

      it "returns full text error messages in JSON" do
        donation_response = json_response
        expect(donation_response[:errors][:amount]).to include "must be greater than 0.0"
      end

      it { should respond_with 422 }
    end
  end
end
