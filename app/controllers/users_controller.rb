class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # mark the golfer as registered if the email address matches
      golfer = Golfer.find_by(email: @user.email)
      golfer.update(is_registered: true) if golfer.present?

      flash[:success] = "You are now registered, please login!"
      redirect_to login_path
    else
      render "users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :email, :password, :password_confirmation, :is_admin)
  end
end
