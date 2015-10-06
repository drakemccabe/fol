class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Article.find(params[:id])
  end

  def index
    respond_with Article.all
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: article, status: 201, location: [:api, article]
    else
      render json: { errors: article.errors }, status: 422
    end
  end

  private

  def article_params
    params.require(:article).permit(:title,
                                    :author,
                                    :category,
                                    :body,
                                    :image_url)
  end
end
