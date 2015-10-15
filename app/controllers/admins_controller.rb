class AdminsController < ApplicationController
  layout "admin"

  def new
    render('articles/_login', layout: 'layouts/login')
  end

  def create
    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email)

    unless user.nil?
      if user.valid_password? user_password
        sign_in user, store: true
        user.generate_authentication_token!
        user.save
        render :index, locals: { token: user.auth_token }
      else
        flash[:notice] = "Invalid email or password"
      end
    end
  end

  def index
    authenticate_with_token!
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    redirect_to articles_path
  end
end
