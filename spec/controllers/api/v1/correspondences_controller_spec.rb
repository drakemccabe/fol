require 'spec_helper'

describe Api::V1::CorrespondencesController do
  describe "GET #show" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      @correspondence = FactoryGirl.create :correspondence
      get :show, id: @correspondence.id
    end

    it "returns the information on a single correspondence" do
      correspondence_response = json_response
      expect(correspondence_response[:note]).to eql @correspondence.note
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when a correspondence is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @correspondence_attributes = FactoryGirl.attributes_for :correspondence
        api_authorization_header user.auth_token
        post :create, { correspondence: @correspondence_attributes }
      end

      it "returns the new correspondence in json" do
        correspondence_response = json_response
        expect(correspondence_response[:note]).to eql @correspondence_attributes[:note]
      end

      it { should respond_with 201 }
    end

    context "when a new correspondence does not save" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_correspondence_attributes = { note: "Smart TV" * 500 }
        api_authorization_header user.auth_token
        post :create, { correspondence: @invalid_correspondence_attributes }
      end

      it "renders errors in json" do
        correspondence_response = json_response
        expect(correspondence_response).to have_key(:errors)
      end

      it "renders full error messages" do
        correspondence_response = json_response
        expect(correspondence_response[:errors][:note]).to include "is too long (maximum is 1000 characters)"
      end

      it { should respond_with 422 }
    end
  end
end
