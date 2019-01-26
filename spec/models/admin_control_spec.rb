require 'rails_helper'

RSpec.describe AdminControl, type: :model do

  let(:admin_control) {AdminControl.new(name: "team_generation_emails", description: "team generation email desc", value: "ON")}

  it "should be valid" do
    expect(admin_control.valid?).to be_truthy
  end

  it "should be invalid when name is blank" do
    admin_control.name = ""
    expect(admin_control.valid?).to be_falsey
  end

  it "should be invalid when description is blank" do
    admin_control.description = ""
    expect(admin_control.valid?).to be_falsey
  end

  it "should be invalid when value is blank" do
    admin_control.value = ""
    expect(admin_control.valid?).to be_falsey
  end

end
