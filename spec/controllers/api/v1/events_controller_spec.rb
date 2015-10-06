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
end
