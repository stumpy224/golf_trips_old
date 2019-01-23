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
              password: "",
              remember_me: ""
          }
      }
    end

    it "should notify user" do
      expect(flash[:error]).to eq "Email and/or password are incorrect"
    end

    it "should render template for new session" do
      expect(response).to render_template "sessions/new"
    end
  end

  describe "with valid information" do

    describe "and not remembering" do
      before(:each) do
        get login_path
        post login_path, params: {
            session: {
                email: jeremiah.email,
                password: "password",
                remember_me: ""
            }
        }
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_url
      end

      it "should login user" do
        expect(is_logged_in?).to be_truthy
      end

      it "should not have a remember token cookie" do
        expect(cookies['remember_token']).to be_nil
      end
    end

    describe "and remembering" do
      before(:each) do
        get login_path
        post login_path, params: {
            session: {
                email: jeremiah.email,
                password: "password",
                remember_me: "on"
            }
        }
      end

      it "should redirect to root" do
        expect(response).to redirect_to root_url
      end

      it "should login user" do
        expect(is_logged_in?).to be_truthy
      end

      it "should have a remember token cookie" do
        expect(cookies['remember_token']).to_not be_empty
      end
    end

  end

end
