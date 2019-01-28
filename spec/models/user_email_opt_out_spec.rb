require 'rails_helper'

RSpec.describe UserEmailOptOut, type: :model do

  let(:jeremiah) {users(:jeremiah)}
  let(:user_email_opt_out) {UserEmailOptOut.new(user_id: jeremiah.id, email_template: "template name")}

  it "should be valid" do
    expect(user_email_opt_out.valid?).to be_truthy
  end

  it "should be invalid when user is blank" do
    user_email_opt_out.user_id = ""
    expect(user_email_opt_out.valid?).to be_falsey
  end

  it "should be invalid when email template is blank" do
    user_email_opt_out.email_template = ""
    expect(user_email_opt_out.valid?).to be_falsey
  end

end
