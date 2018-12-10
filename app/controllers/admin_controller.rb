class AdminController < ApplicationController
  before_action :is_admin?

  def index
    @users = User.all
  end

  def admin_toggle
    @user = User.find(params[:id])
    Logger.info "found user with id: #{@user.id}, and email: #{@user.email}"
  end

  private

  def is_admin?
    unless logged_in?
      redirect_to login_url
    end

    unless current_user.is_admin?
      redirect_to root_url
    end
  end
end
