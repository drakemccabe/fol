class PaymentsController < ApplicationController
  def index
    @customer = params[:stripeBillingName]
  end

  def create
    customer = Stripe::Customer.create(source: params[:stripeToken],
                                       description: params[:stripeBillingName],
                                       metadata: { address: params[:stripeBillingAddressLine1],
                                                   zip: params[:stripeBillingAddressZip],
                                                   state: params[:stripeBillingAddressState],
                                                   city: params[:stripeBillingAddressCity],
                                                   country: params[:stripeBillingAddressCountry],
                                                   email: params[:stripeEmail] })

    begin
      charge = Stripe::Charge.create(amount: params[:amount],
                                     currency: "usd",
                                     customer: customer.id,
                                     description: "Friends of the Library Membership")
    rescue Stripe::CardError: e
      #declined
    end
  end
end
