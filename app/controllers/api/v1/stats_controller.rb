class Api::V1::StatsController < ApplicationController
  #before_action :authenticate_with_token!
  respond_to :json

  def index
    respond_with Donation.where("date(created_at) > ?", 30.days.ago)
      .group("date(created_at)").count.sort_by{|k, _| k}
  end

  def show
    respond_with Donation.where("date(created_at) > ?", 365.days.ago)
      .group("date(created_at)").count.sort_by{|k, _| k}
  end
end
