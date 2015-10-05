require 'spec_helper'

describe Api::V1::ContactsController do
  describe "GET #show" do
    before(:each) do
      @contact = FactoryGirl.create :contact
      api_authorization_header user.auth_token
      get :show, id: @contact.id
    end

    it "returns information about a contact" do
      contact_response = json_response
      expect(contact_response[:first_name]).to eql @contact.first_name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :contact }
      api_authorization_header user.auth_token
      get :index
    end

    it "returns 4 contacts from the database" do
      contact_response = json_response
      expect(contact_response[:contacts]).to have(4).items
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when contact is successfully made" do
      before(:each) do
        @contact_attributes = FactoryGirl.attributes_for :contact
        api_authorization_header user.auth_token
        post :create, { contact: @contact_attributes }
      end

      it "renders json for the contact just created" do
        contact_response = json_response
        expect(contact_response[:first_name]).to eql @contact_attributes[:first_name]
      end

      it { should respond_with 201 }
    end

    context "when fails to save" do
      before(:each) do
        @invalid_contact_attributes = { state: "Massachusetts" }
        api_authorization_header user.auth_token
        post :create, { contact: @invalid_contact_attributes }
      end

      it "renders an errors json" do
        contact_response = json_response
        expect(contact_response).to have_key(:errors)
      end

      it "returns error messages" do
        contact_response = json_response
        expect(contact_response[:errors][:state]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end
end
