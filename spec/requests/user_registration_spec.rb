require 'rails_helper'

RSpec.describe "User registering", type: :request do

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
    # it "should create user" do
    #   origCount = User.count
    #
    #   post users_path, params: {
    #       user: {
    #           first_name: "Valid",
    #           last_name: "User",
    #           email: "user@valid.com",
    #           password: "valid_user",
    #           password_confirmation: "valid_user",
    #           activation_token: User.new_token
    #       }
    #   }
    #
    #   expect(User.count).to eq(origCount + 1)
    # end
    #
    # it "should send activation email" do
    #   expect(ActionMailer::Base.deliveries.size).to eq(1)
    # end
    #
    # it "should notify user" do
    #   expect(flash[:info]).to eq "Please check your email to activate your account"
    # end
    #
    # it "should redirect to root" do
    #   expect(response).to redirect_to root_url
    # end
  end
end
