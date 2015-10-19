class FormsController < ApplicationController
  def create
    c = ContactForm.new(contact_form_params)
    if c.deliver
      redirect_to root_path, flash: { message: "Thanks for contacting us, we'll get back shortly." }
    else
      redirect_to root_path, flash: { error: "Sorry, form could not send, please try again."}
    end
  end

  def contact_form_params
    params.permit(:name, :email, :phone, :message)
  end
end
