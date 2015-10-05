class ArticlesController < ApplicationController
  def index
    @articles = Article.order(:created_at).limit(4).reverse_order
    @events = Event.order(:created_at).limit(3).reverse_order
  end

  def show
    @article = Article.find(article_params[:id])
  end

  def new
    @article = Article.new
  end
end
