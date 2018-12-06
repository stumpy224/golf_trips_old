require 'rails_helper'

RSpec.describe "Password reset", type: :request do
  let(:jeremiah) {users(:jeremiah)}

  before(:each) do
    ActionMailer::Base.deliveries.clear
    get new_password_reset_path
  end

  it "should render template for new password reset" do
    expect(response).to render_template "password_resets/new"
  end

  describe "with invalid email" do

    before(:each) do
      post password_resets_path, params: {password_reset: {email: ""}}
    end

    it "should notify the user" do
      expect(flash[:error]).to eq "Email not found or invalid"
    end

    it "should render template for new password reset" do
      expect(response).to render_template("password_resets/new")
    end

  end

  describe "with valid email" do

    before(:each) do
      post password_resets_path, params: {password_reset: {email: jeremiah.email}}
    end

    it "should create reset digest" do
      expect(jeremiah.reset_digest).not_to eq jeremiah.reload.reset_digest
    end

    it "should notify the user" do
      expect(flash[:info]).to eq "Please check your email for password reset instructions"
    end

    it "should send email" do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_url
    end

  end

  describe "on new password form" do

    describe "with wrong email" do
      it "should redirect to root" do
        get edit_password_reset_path(User.new_token, email: "")
        expect(response).to redirect_to root_url
      end
    end

    describe "with inactive user" do
      it "should redirect to root" do
        jeremiah.toggle!(:is_activated)
        get edit_password_reset_path(User.new_token, email: "")
        expect(response).to redirect_to root_url
        jeremiah.toggle!(:is_activated)
      end
    end

    describe "with right email but wrong token" do
      it "should redirect to root" do
        get edit_password_reset_path("wrong token", email: jeremiah.email)
        expect(response).to redirect_to root_url
      end
    end

    describe "with right email and right token" do
      before(:each) do
        jeremiah.create_reset_digest
      end

      it "should render template for edit password reset" do
        get edit_password_reset_path(jeremiah.reset_token, email: jeremiah.email)
        expect(response).to render_template "password_resets/edit"
      end

      it "should login" do
        patch password_reset_path(jeremiah.reset_token), params: {
            email: jeremiah.email,
            user: {
                password: "testing",
                password_confirmation: "testing"
            }
        }
        expect(response).to render_template "users/show"
      end

      # describe "with empty password" do
      #   it "should notify the user" do
      #     patch password_reset_path(jeremiah.reset_token), params: {
      #         email: jeremiah.email,
      #         user: {
      #             password: "",
      #             password_confirmation: ""
      #         }
      #     }
      #     expect(jeremiah.errors).to include "Password can't be empty'"
      #   end
      # end
      #
      # describe "with non-matching password and confirmation" do
      #   it "should notify the user" do
      #     patch password_reset_path(jeremiah.reset_token), params: {
      #         email: jeremiah.email,
      #         user: {
      #             password: "foobaz",
      #             password_confirmation: "barquux"
      #         }
      #     }
      #     expect(flash[:error]).to eq "Please check your email for password reset instructions"
      #   end
      # end

    end
  end
end
