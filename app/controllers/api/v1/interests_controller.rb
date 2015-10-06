class Api::V1::InterestsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Interest.find(params[:id])
  end

  def index
   respond_with Interest.all
  end

  def create
    interest = Interest.new(interest_params)
    if interest.save
      render json: interest, status: 201, location: [:api, interest]
    else
      render json: { errors: interest.errors }, status: 422
    end
  end

  def update
    interest = Interest.find(params[:id])
    if interest.update(interest_params)
      render json: interest, status: 200, location: [:api, interest]
    else
      render json: { errors: interest.errors }, status: 422
    end
  end

  private

    def interest_params
      params.require(:interest).permit(:interest, :contact_id)
    end
end
