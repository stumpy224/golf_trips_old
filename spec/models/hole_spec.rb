require 'rails_helper'

RSpec.describe Hole, type: :model do

  let (:peninsula) {courses(:peninsula)}
  let (:hole) {Hole.new(course_id: peninsula.id, number: 1, par: 4, handicap: 3)}

  it "should be valid" do
    expect(hole.valid?).to be_truthy
  end

  it "should be invalid when course is blank" do
    hole.course_id = ""
    expect(hole.valid?).to be_falsey
  end

  it "should be invalid when number is blank" do
    hole.number = ""
    expect(hole.valid?).to be_falsey
  end

  it "should be invalid when par is blank" do
    hole.par = ""
    expect(hole.valid?).to be_falsey
  end

end
