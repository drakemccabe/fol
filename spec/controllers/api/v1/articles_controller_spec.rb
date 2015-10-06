require 'spec_helper'

describe Api::V1::ArticlesController do
  describe "GET #show" do
      before(:each) do
        user = FactoryGirl.create :user
        api_authorization_header user.auth_token
        @article = FactoryGirl.create :article
        get :show, id: @article.id
      end

      it "returns json version of object" do
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

    describe "POST #create" do
     context "when a new article saves" do
       before(:each) do
         user = FactoryGirl.create :user
         @article_attributes = FactoryGirl.attributes_for :article
         api_authorization_header user.auth_token
         post :create, { article: @article_attributes }
       end

       it "returns object just saved in json" do
         article_response = json_response
         expect(article_response[:title]).to eql @article_attributes[:title]
       end

       it { should respond_with 201 }
     end

     context "when article does not save" do
       before(:each) do
         user = FactoryGirl.create :user
         @invalid_article_attributes = { title: "article" }
         api_authorization_header user.auth_token
         post :create, { user_id: user.id, article: @invalid_article_attributes }
       end

       it "returns errors is json" do
         article_response = json_response
         expect(article_response).to have_key(:errors)
       end

       it "returns full error messages for user" do
         article_response = json_response
         expect(article_response[:errors][:category]).to include "can't be blank"
       end

       it { should respond_with 422 }
     end
   end

   describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @article = FactoryGirl.create :article
      api_authorization_header @user.auth_token
    end

    context "when article updates successfully" do
      before(:each) do
        patch :update, { id: @article.id,
              article: { title: "A really awesome title" } }
      end

      it "returns the updated article object in json" do
        article_response = json_response
        expect(article_response[:title]).to eql "A really awesome title"
      end

      it { should respond_with 200 }
    end

    context "when article fails to update" do
      before(:each) do
        patch :update, { id: @article.id,
              article: { category: "char" * 300 } }
      end

      it "returns error messages" do
        article_response = json_response
        expect(article_response).to have_key(:errors)
      end

      it "returns full error messages in json" do
        article_response = json_response
        expect(article_response[:errors][:category]).to include "is too long (maximum is 300 characters)"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @article = FactoryGirl.create :article
      api_authorization_header @user.auth_token
      delete :destroy, { id: @article.id }
    end

    it { should respond_with 204 }
  end
end
