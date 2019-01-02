require 'rails_helper'

RSpec.describe LodgingType, type: :model do

  before(:each) do
    @lodging_type = LodgingType.create(name: "Villa")
  end

  it "should be valid" do
    expect(@lodging_type.valid?).to be_truthy
  end

  it "should be invalid when name is blank" do
    @lodging_type.name = ""
    expect(@lodging_type.valid?).to be_falsey
  end

end
