class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.is_activated? && user.is_authenticated?(:activation, params[:id])
      user.activate
      login(user)
      flash[:success] = "Your account has been activated"
    else
      flash[:error] = "Your activation link is invalid"
    end

    redirect_to root_url
  end
end
