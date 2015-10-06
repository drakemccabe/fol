require 'spec_helper'

describe Api::V1::AtriclesController do
  describe "GET #show" do
      before(:each) do
        @article = FactoryGirl.create :article
        get :show, id: @article.id
      end

      it "returns the information about a reporter on a hash" do
        article_response = json_response
        expect(article_response[:title]).to eql @article.title
      end

      it { should respond_with 200 }
    end

end
