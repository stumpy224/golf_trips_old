class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
      # flash[:success] = "You are now logged in!"
    else
      flash.now[:error] = "Please check your email and password!"
      render "sessions/new"
    end
  end

  def destroy
    logout
    flash[:success] = "You have successfully logged out!"
    redirect_to root_url
  end
end
