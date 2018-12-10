require 'rails_helper'

RSpec.describe "User mailer" do
  before(:each) do
    @user = users(:jeremiah)
  end

  describe "sending account activation email" do
    before(:each) do
      @user.activation_token = User.new_token
      @activation_email = UserMailer.account_activation(@user)
    end

    it "should come from Golf Hacker Club's Gmail" do
      expect(@activation_email.from).to eq(["golfhackerclub@gmail.com"])
    end

    it "should have Account Activation in the subject" do
      expect(@activation_email.subject).to include "Account Activation"
    end

    it "should be sent to user" do
      expect(@activation_email.to).to eq(["stumpy@test.com"])
    end

    it "should have activation token in body" do
      expect(@activation_email.body.encoded).to include @user.activation_token
    end

    it "should have user email in body" do
      expect(@activation_email.body.encoded).to include CGI.escape(@user.email)
    end
  end

  describe "sending password reset email" do
    before(:each) do
      @user.reset_token = User.new_token
      @password_reset_email = UserMailer.password_reset(@user)
    end

    it "should come from Golf Hacker Club's Gmail" do
      expect(@password_reset_email.from).to eq(["golfhackerclub@gmail.com"])
    end

    it "should have Account Activation in the subject" do
      expect(@password_reset_email.subject).to include "Password Reset"
    end

    it "should be sent to user" do
      expect(@password_reset_email.to).to eq(["stumpy@test.com"])
    end

    it "should have activation token in body" do
      expect(@password_reset_email.body.encoded).to include @user.reset_token
    end

    it "should have user email in body" do
      expect(@password_reset_email.body.encoded).to include CGI.escape(@user.email)
    end
  end

end
