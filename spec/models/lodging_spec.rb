require 'rails_helper'

RSpec.describe Lodging, type: :model do

  before(:each) do
    @lodging_type = lodging_types(:villa)
    @lodging = Lodging.new(lodging_type_id: @lodging_type.id, room: "Test Lodging Room")
  end

  it "should be valid" do
    expect(@lodging.valid?).to be_truthy
  end

  it "should be invalid when room is blank" do
    @lodging.room = ""
    expect(@lodging.valid?).to be_falsey
  end

end
