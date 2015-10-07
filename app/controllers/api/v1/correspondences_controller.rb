class Api::V1::CorrespondencesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Correspondence.find(params[:id])
  end

  def index
    respond_with Correspondence.all
  end

  def create
    correspondence = Correspondence.new(correspondence_params)
    if correspondence.save
      render json: correspondence, status: 201, location: [:api, correspondence]
    else
      render json: { errors: correspondence.errors }, status: 422
    end
  end

  def update
    correspondence = Correspondence.find(params[:id])
    if correspondence.update(correspondence_params)
      render json: correspondence, status: 200, location: [:api, correspondence]
    else
      render json: { errors: correspondence.errors }, status: 422
    end
  end

  def destroy
    correspondence = Correspondence.find(params[:id])
    correspondence.destroy
    head 204
  end

private

  def correspondence_params
    params.require(:correspondence).permit(:note, :contact_id)
  end
end
