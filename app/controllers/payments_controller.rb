class PaymentsController < ApplicationController

  def index
  end

  def create
    customer = Stripe::Customer.create(card: params[:stripeToken],
                                       email: params[:stripeEmail],
                                       description: "Friends of the Library Membership")

    charge = Stripe::Charge.create(amount: params[:amount].to_i * 100,
                                   currency: "usd",
                                   customer: customer.id)
    if charge.paid
      donation = NewDonation.new(customer, params[:amount].to_i * 100, charge)
      saved_donation = donation.add_donation!

      Payment.create(token: params[:stripeToken].to_s,
                     schedule: false,
                     donation_id: Donation.last.id,
                     customer_id: customer.id.to_s)

     render :index
    else
      flash[:error] = charge.failure_message
    end
   rescue Stripe::CardError => e
    flash[:error] = e.message
     redirect_to articles_index
  end
end
