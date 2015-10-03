class PaymentsController < ApplicationController

  def index
    @articles = Article.order(:created_at).limit(4)
    @events = Event.order(:created_at).limit(3)
  end

  def create
    customer = Stripe::Customer.create(card: params[:stripeToken],
                                       email: params[:stripeEmail],
                                       description: "Friends of the Library Membership")

    charge = Stripe::Charge.create(amount: params[:amount],
                                   currency: "usd",
                                   customer: customer.id)
    if charge.paid
      donation = NewDonation.new(customer, params[:amount], charge)
      donation.add_donation!

      Payment.create(token: params[:stripeToken],
                     schedule: "false",
                     donation_id: donation.id,
                     customer_id: customer.id)

     flash[:message] = "Thanks"
    else
      flash[:error] = charge.failure_message
    end
   rescue Stripe::CardError => e
    flash[:error] = e.message
     redirect_to articles_index
  end
end
