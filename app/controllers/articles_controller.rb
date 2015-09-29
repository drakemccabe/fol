class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(article_params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'New Blog Entry Created!'
      redirect_to @article
    else
      flash[:errors] = @article.errors.full_messages.join(". ")
      render :new
    end
  end
end
