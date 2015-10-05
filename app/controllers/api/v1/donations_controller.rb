class Api::V1::DonationsController < ApplicationController
  respond_to :json

  def show
    respond_with Donation.find(params[:id])
  end

  def index
    respond_with Donation.all.order(:created_at).limit(1000)
  end

  def create
    #add donation class
    donation = donation.new(donation_params)
    if donation.save
      render json: product, status: 201, location: [:api, product]
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :contact_id)
  end
end
