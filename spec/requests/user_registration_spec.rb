require 'rails_helper'

RSpec.describe "User registering" do

  before(:each) do
    ActionMailer::Base.deliveries.clear
    get new_user_path
  end

  describe "with invalid account information" do
    it "should render template for new user" do
      expect(response).to render_template "users/new"
    end

    it "should not save invalid user" do
      origCount = User.count

      post users_path, params: {
          user: {
              first_name: "Invalid",
              last_name: "User",
              email: "user@invalid",
              password: "foo",
              password_confirmation: "bar"
          }
      }

      expect(User.count).to eq(origCount)
    end
  end

  describe "with valid account information" do
    before(:each) do
      @origCount = User.count

      post users_path, params: {
          user: {
              first_name: "Valid",
              last_name: "User",
              email: "user@valid.com",
              password: "valid_user",
              password_confirmation: "valid_user"
          }
      }

      @user = assigns(:user)
    end

    it "should create user" do
      expect(User.count).to eq(@origCount + 1)
    end

    it "should send activation email" do
      expect(ApplicationMailer.deliveries.size).to eq(1)
    end

    it "should notify user" do
      expect(flash[:info]).to eq "Please check your email to activate your account"
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_url
    end

    it "should not activate user" do
      expect(@user.is_activated?).to be_falsey
    end

    it "should not login user" do
      log_in_as(@user)
      expect(is_logged_in?).to be_falsey
    end

    describe "with clicking activation url from email" do
      before(:each) do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
      end

      it "should activate user" do
        expect(@user.reload.is_activated?).to be_truthy
      end

      it "should login user" do
        follow_redirect!
        expect(is_logged_in?).to be_truthy
      end
    end
  end
end
