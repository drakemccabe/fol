class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def show
    respond_with Contact.find(params[:id])
  end

  def index
    respond_with Contact.all.limit(50)
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact, status: 201, location: [:api, contact]
    else
      render json: { errors: contact.errors }, status: 422
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact, status: 200, location: [:api, contact]
    else
      render json: { errors: contact.errors }, status: 422
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    head 204
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name,
                                    :last_name,
                                    :address,
                                    :city,
                                    :state,
                                    :zip,
                                    :phone,
                                    :email,
                                    :is_business,
                                    :is_family,
                                    :is_resident,
                                    :longitude,
                                    :latitude)
  end
end
