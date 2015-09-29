require 'spec_helper'

describe EventsController, type: :controller do
  describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
  end

  describe "GET #show" do
      it "returns http success" do
        event = FactoryGirl.create(:event)
        get :show, event: event.id
        expect(response).to have_http_status(:success)
      end
  end
end
