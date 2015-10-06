class Api::V1::InterestsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Interest.find(params[:id])
  end
end
