require 'spec_helper'

describe Api::V1::AtriclesController do
  describe "GET #show" do
      before(:each) do
        user = FactoryGirl.create :user
        api_authorization_header user.auth_token
        @article = FactoryGirl.create :article
        get :show, id: @article.id
      end

      it "returns the information about a reporter on a hash" do
        article_response = json_response
        expect(article_response[:title]).to eql @article.title
      end

      it { should respond_with 200 }
    end

    describe "GET #index" do
      before(:each) do
        user = FactoryGirl.create :user
        api_authorization_header user.auth_token
        4.times { FactoryGirl.create :article }
        get :index
      end

      it "returns 4 records from the database" do
        article_response = json_response
        expect(article_response[:articles]).to have(4).items
      end

      it { should respond_with 200 }
    end


end
