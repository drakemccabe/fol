class Api::V1::EventsController < ApplicationController
  def show
    respond_with Event.find(params[:id])
  end

  def index
    respond_with Event.all
  end
end
