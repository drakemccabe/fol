require 'spec_helper'

describe Api::V1::EventsController do
  describe "GET" do
    before(:each) do
       user = FactoryGirl.create :user
       api_authorization_header user.auth_token
       @event = FactoryGirl.create :event
       get :show, id: @event.id
    end

    it "returns the information about a single event" do
      event_response = json_response
      expect(event_response[:name]).to eql @event.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      6.times { FactoryGirl.create :event }
      get :index
    end

    it "returns 6 event objects in json" do
      events_response = json_response
      expect(events_response[:events].size).to eq(6)
    end

    it { should respond_with 200 }
  end

  describe "POST" do
    context "when a new event saves" do
      before(:each) do
        user = FactoryGirl.create :user
        @event_attributes = FactoryGirl.attributes_for :event
        api_authorization_header user.auth_token
        post :create, { event: @event_attributes }
      end

      it "returns the new event data back in json" do
        event_response = json_response
        expect(event_response[:name]).to eql @event_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when event fails to save" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_event_attributes = { name: "Only Name" }
        api_authorization_header user.auth_token
        post :create, { event: @invalid_event_attributes }
      end

      it "creates errors when it doesn't save" do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it "returns the full error messages to the client" do
        event_response = json_response
        expect(event_response[:errors][:location]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
