class ArticlesController < ApplicationController
  def index
    @articles = Article.order(:created_at).limit(4).reverse_order
    @events = Event.where("event_date > ?", Date.today).order(:event_date).limit(3)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end
end
