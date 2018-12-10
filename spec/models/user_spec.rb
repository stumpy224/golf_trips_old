require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(first_name: "Testy", last_name: "McTesterson", email: "testy@test.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  it "should be valid" do
    expect(@user.valid?).to be_truthy
  end

  it "should be invalid when first name is blank" do
    @user.first_name = ""
    expect(@user.valid?).to be_falsey
  end

  it "should be invalid when last name is blank" do
    @user.last_name = ""
    expect(@user.valid?).to be_falsey
  end

  it "should be invalid when password is less than minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user.valid?).to be_falsey
  end

  describe "email" do
    it "should be invalid when blank" do
      @user.email = ""
      expect(@user.valid?).to be_falsey
    end

    it "should be invalid when doesn't match regex" do
      @user.email = "test;@invalid.com"
      expect(@user.valid?).to be_falsey
    end

    it "should be invalid when not unique" do
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user.valid?).to be_falsey
    end

    it "should be saved as lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

end
