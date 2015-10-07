class Api::V1::CorrespondencesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Correspondence.find(params[:id])
  end

  def create
    correspondence = Correspondence.new(correspondence_params)
    if correspondence.save
      render json: correspondence, status: 201, location: [:api, correspondence]
    else
      render json: { errors: correspondence.errors }, status: 422
    end
  end

private

  def correspondence_params
    params.require(:correspondence).permit(:note, :contact_id)
  end
end
