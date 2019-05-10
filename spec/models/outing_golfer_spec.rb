require 'rails_helper'

RSpec.describe OutingGolfer, type: :model do

  let (:outing) {outings(:peninsula_2018)}
  let (:golfer) {golfers(:jeremiah_stump)}
  let (:outing_golfer) {OutingGolfer.new(outing_id: outing.id, golfer_id: golfer.id)}

  it "should be valid" do
    expect(outing_golfer.valid?).to be_truthy
  end

  it "should be invalid when outing is blank" do
    outing_golfer.outing_id = ""
    expect(outing_golfer.valid?).to be_falsey
  end

  it "should be invalid when golfer is blank" do
    outing_golfer.golfer_id = ""
    expect(outing_golfer.valid?).to be_falsey
  end

end
