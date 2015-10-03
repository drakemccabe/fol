class ArticlesController < ApplicationController
  def index
    @articles = Article.order(:created_at)
  end

  def show
    @article = Article.find(article_params[:id])
  end

  def new
    @article = Article.new
  end
end
