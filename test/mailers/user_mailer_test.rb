require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:jeremiah)
    user.activation_token = User.new_token

    mail = UserMailer.account_activation(user)

    assert_includes mail.subject, "Account Activation"
    assert_equal mail.to, ["stumpy@test.com"]
    assert_equal mail.from, ["golfhackerclub@gmail.com"]
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:jeremiah)
    user.reset_token = User.new_token

    mail = UserMailer.password_reset(user)

    assert_includes mail.subject, "Password Reset"
    assert_equal mail.to, ["stumpy@test.com"]
    assert_equal mail.from, ["golfhackerclub@gmail.com"]
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

end
