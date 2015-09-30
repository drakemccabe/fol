class Api::V1::DonationsController < ApplicationController
  respond_to :json

  def show
    respond_with Donation.find(params[:id])
  end

  def index
    respond_with Donation.all.order(:created_at).limit(1000)
  end
end
