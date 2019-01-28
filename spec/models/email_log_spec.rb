require 'rails_helper'

RSpec.describe EmailLog, type: :model do

  let(:email_log) {EmailLog.new(template: "test template", subject: "test subject", body: "<body></body>", sent_to: "test@test.com")}

  it "should be valid" do
    expect(email_log.valid?).to be_truthy
  end

  it "should be invalid when template is blank" do
    email_log.template = ""
    expect(email_log.valid?).to be_falsey
  end

  it "should be invalid when subject is blank" do
    email_log.subject = ""
    expect(email_log.valid?).to be_falsey
  end

  it "should be invalid when sent to is blank" do
    email_log.sent_to = ""
    expect(email_log.valid?).to be_falsey
  end

end
