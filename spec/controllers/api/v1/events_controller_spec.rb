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
end
