require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jeremiah)
  end

  # test "unsuccessful edit" do
  #   get user_path(@user)
  #   assert_template 'users/show'
  #   patch user_path(@user), params: { user: { name:  "",
  #                                             email: "foo@invalid",
  #                                             password:              "foo",
  #                                             password_confirmation: "bar" } }
  #
  #   assert_template 'users/show'
  # end
end
