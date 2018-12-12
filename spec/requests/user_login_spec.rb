require 'rails_helper'

RSpec.describe "User logging in" do

  let(:jeremiah) {users(:jeremiah)}

  before(:each) do
    get login_path
  end

  it "should render template for new session" do
    expect(response).to render_template "sessions/new"
  end

  describe "with invalid information" do
    before(:each) do
      post login_path, params: {
          session: {
              email: "",
              password: ""
          }
      }
    end

    it "should notify user" do
      expect(flash[:error]).to eq "Email and password are incorrect"
    end

    it "should render template for new session" do
      expect(response).to render_template "sessions/new"
    end
  end

  describe "with valid information" do
    before(:each) do
      get login_path
      post login_path, params: {
          session: {
              email: jeremiah.email,
              password: "password"
          }
      }
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_url
    end

    it "should login user" do
      expect(is_logged_in?).to be_truthy
    end

    describe "followed by logout" do
      before(:each) do
        delete logout_path
      end

      it "should logout user" do
        expect(is_logged_in?).to be_falsey
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_url
      end
    end
  end

end
