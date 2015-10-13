class Api::V1::DonationsController < ApplicationController
  #before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Donation.find(params[:id])
  end

  def index
    respond_with Donation.all.order(:created_at).limit(100)
  end

  def create
    donation = Donation.new(donation_params)
    if donation.save
      render json: donation, status: 201, location: [:api, donation]
    else
      render json: { errors: donation.errors }, status: 422
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :contact_id, :created_at)
  end
end
