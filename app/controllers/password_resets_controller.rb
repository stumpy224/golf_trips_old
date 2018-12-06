class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by(email: params[:password_reset][:email].downcase)
    if user
      user.create_reset_digest
      user.send_password_reset_email
      flash[:info] = "Please check your email for password reset instructions"
      redirect_to root_path
    else
      flash.now[:error] = "Email not found or invalid"
      render 'password_resets/new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'password_resets/edit'
    elsif @user.update_attributes(user_params)
      login(@user)
      @user.update_columns(reset_digest: nil, reset_sent_at: nil)
      flash.now[:success] = "Password has been reset"
      render 'users/show'
    else
      render 'password_resets/edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.is_activated? && @user.is_authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.is_password_reset_expired?
      flash[:warning] = "Password reset has expired"
      redirect_to new_password_reset_url
    end
  end
end
