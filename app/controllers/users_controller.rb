class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @user_email_opt_outs = UserEmailOptOut.where(user_id: @user.id)
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
    @user_email_opt_outs = UserEmailOptOut.where(user_id: @user.id)

    orig_email = @user.email

    if @user.update(user_params)
      # synchronize Golfer info with User info if the email address matches
      #  fyi - leaving out first_name / last_name as bogus updates could lead to confusion
      golfer = Golfer.find_by(email: orig_email)
      golfer.update(
          # first_name: user_params[:first_name],
          # last_name: user_params[:last_name],
          nickname: user_params[:nickname],
          email: user_params[:email],
          phone: user_params[:phone]
      ) if golfer.present?
      flash.now[:success] = "Profile has been updated"
    end

    render "users/show"
  end

  def email_prefs
    is_checked = params[:is_checked].to_s == "true" ? true : false
    email_template = params[:email_template]

    if is_checked
      user_email_opt_out = UserEmailOptOut.where(user_id: current_user.id).where(email_template: email_template).first
      user_email_opt_out.destroy unless user_email_opt_out.nil?
    else
      UserEmailOptOut.create(user_id: current_user.id, email_template: email_template)
    end

    flash_verbiage = get_email_prefs_flash_verbiage(email_template)
    flash[:success] = is_checked ? "You will be notified #{flash_verbiage}" : "You will no longer be notified #{flash_verbiage}"
    redirect_to user_path(current_user)
  end

  def unsubscribe
    user = User.find_by_uuid(params[:uuid])
    UserEmailOptOut.create(user_id: user.id, email_template: params[:email_template]) unless user.nil?
    flash[:info] = "You have been unsubscribed!"
    redirect_to root_path
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

  def get_email_prefs_flash_verbiage(email_template)
    case email_template
    when EMAIL_TEMPLATE_FOR_TEAM_RESULTS
      return "with Team Results"
    end
    return ""
  end

  def logged_in_user
    unless logged_in?
      flash[:error] = "Please login"
      redirect_to login_path
    end
  end
end
