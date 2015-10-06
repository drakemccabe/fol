class Api::V1::EventsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Event.find(params[:id])
  end

  def index
    respond_with Event.all
  end

  def create
    event = Event.new(product_params)
    if event.save
      render json: event, status: 201, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(product_params)
      render json: event, status: 200, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

  private

  def product_params
    params.require(:event).permit(:name,
                                  :location,
                                  :description,
                                  :image_url,
                                  :event_date)
  end
end
