class Api::V1::AtriclesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Product.find(params[:id])
  end

  def index
    respond_with Product.all
  end
end
