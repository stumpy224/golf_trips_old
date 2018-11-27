class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.is_activated?
        login(user)
        redirect_to root_url
      else
        message = "Account not activated.<br>"
        message += "Check your email for the activation link."
        flash.now[:error] = message
        render "sessions/new"
      end
    else
      flash.now[:error] = "Email and password are incorrect"
      render "sessions/new"
    end
  end

  def destroy
    logout
    flash[:success] = "You have been logged out"
    redirect_to root_url
  end
end
