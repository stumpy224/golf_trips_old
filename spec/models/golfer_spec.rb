require 'rails_helper'

RSpec.describe Golfer, type: :model do

  before(:each) do
    @golfer = Golfer.new(first_name: "Testy", last_name: "McTesterson", email: "testy@test.com")
  end

  it "should be valid" do
    expect(@golfer.valid?).to be_truthy
  end

  it "should be invalid when first name is blank" do
    @golfer.first_name = ""
    expect(@golfer.valid?).to be_falsey
  end

  it "should be invalid when last name is blank" do
    @golfer.last_name = ""
    expect(@golfer.valid?).to be_falsey
  end

  describe "email" do
    it "should be invalid when blank" do
      @golfer.email = ""
      expect(@golfer.valid?).to be_falsey
    end

    it "should be invalid when doesn't match regex" do
      @golfer.email = "test;@invalid.com"
      expect(@golfer.valid?).to be_falsey
    end

    it "should be invalid when not unique" do
      duplicate_user = @golfer.dup
      @golfer.save
      expect(duplicate_user.valid?).to be_falsey
    end

    it "should be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @golfer.email = mixed_case_email
      @golfer.save
      expect(@golfer.reload.email).to eq(mixed_case_email.downcase)
    end
  end

end
