class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # mark the Golfer as registered if the email address matches
      golfer = Golfer.find_by(email: @user.email)
      golfer.update(is_registered: true) if golfer.present?

      @user.send_activation_email

      flash[:info] = "Please check your email to activate your account"

      redirect_to root_path
    else
      render "users/new"
    end
  end

  def update
    @user = User.find(params[:id])
    orig_email = @user.email

    if @user.update(user_params)
      # update the Golfer email if the email address matches
      golfer = Golfer.find_by(email: orig_email)
      golfer.update(email: user_params[:email]) if golfer.present?
      flash.now[:success] = "Account updated"
    end

    render 'users/show'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :email, :password, :password_confirmation)
  end

  # Before actions

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def logged_in_user
    unless logged_in?
      flash[:error] = "Please login"
      redirect_to login_path
    end
  end
end
