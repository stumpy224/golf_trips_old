require 'rails_helper'

RSpec.describe Course, type: :model do

  let(:course) {Course.new(name: "Riviera Golf Club", address: "1234 South Street, Panama, FL", phone: "9872987982", url: "http://www.riviera.com")}

  it "should be valid" do
    expect(course.valid?).to be_truthy
  end

  it "should be invalid when name is blank" do
    course.name = ""
    expect(course.valid?).to be_falsey
  end

  it "should be invalid when address is blank" do
    course.address = ""
    expect(course.valid?).to be_falsey
  end

  it "should be invalid when phone is blank" do
    course.phone = ""
    expect(course.valid?).to be_falsey
  end

end
