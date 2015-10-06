require 'spec_helper'

describe Api::V1::EventsController do
  describe "GET" do
    before(:each) do
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
      6.times { FactoryGirl.create :event }
      get :index
    end

    it "returns 6 event objects in json" do
      events_response = json_response
      expect(events_response[:events]).to have(6).items
    end

    it { should respond_with 200 }
  end
end
