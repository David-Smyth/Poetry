class SessionsController < ApplicationController

  def new
  end

  def create
    email_as_entered    = params[:session][:email]
    password_as_entered = params[:session][:password]
    user = User.find_by(lc_email: email_as_entered.downcase)
    if user.nil?
      flash.now[:error] = "That email address does not match any registered user"
      render 'new'
    elsif !user.authenticate(password_as_entered)
      flash.now[:error] = "Invalid password"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
