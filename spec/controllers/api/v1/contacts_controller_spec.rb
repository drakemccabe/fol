require 'spec_helper'

describe Api::V1::ContactsController do
  describe "GET #show" do
    before(:each) do
      @contact = FactoryGirl.create :contact
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
      get :index
    end

    it "returns 4 contacts from the database" do
      contact_response = json_response
      expect(contact_response[:contacts]).to have(4).items
    end

    it { should respond_with 200 }
  end
end
