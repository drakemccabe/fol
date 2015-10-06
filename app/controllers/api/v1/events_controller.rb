class Api::V1::EventsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Event.find(params[:id])
  end

  def index
    respond_with Event.all
  end
end
