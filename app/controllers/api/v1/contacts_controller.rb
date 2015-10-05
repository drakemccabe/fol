class Api::V1::ContactsController < ApplicationController
  respond_to :json

  def show
    respond_with Contact.find(params[:id])
  end

  def index
    respond_with Contact.all
  end
end
