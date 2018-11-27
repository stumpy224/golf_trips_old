require 'test_helper'

class UsersRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "valid registration with account activation" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
          user: {
              first_name: "Test",
              last_name: "User",
              email: "test@example.com",
              password: "testing",
              password_confirmation: "testing"
          }
      }
    end

    assert_equal ActionMailer::Base.deliveries.size, 1

    user = assigns(:user)

    # user is not activated
    assert_not user.is_activated?

    # user cannot login until activated
    log_in_as(user)
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.is_activated?

    follow_redirect!
    assert is_logged_in?
  end

  test "invalid account information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
end
