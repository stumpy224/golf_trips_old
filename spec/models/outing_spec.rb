require 'rails_helper'

RSpec.describe Outing, type: :model do

  let(:peninsula) {courses(:peninsula)}
  let(:outing) {Outing.new(course_id: peninsula.id, name: "2019 Peninsula", start_date: Date.strptime("05/19/2018", '%m/%d/%Y'), end_date: Date.strptime("05/22/2018", '%m/%d/%Y'))}

  it "should be valid" do
    expect(outing.valid?).to be_truthy
  end

  it "should be invalid when name is blank" do
    outing.name = ""
    expect(outing.valid?).to be_falsey
  end

  it "should be invalid when start date is blank" do
    outing.start_date = ""
    expect(outing.valid?).to be_falsey
  end

  it "should be invalid when end date is blank" do
    outing.end_date = ""
    expect(outing.valid?).to be_falsey
  end

end
