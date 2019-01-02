require 'rails_helper'

RSpec.describe Team, type: :model do

  before(:each) do
    @outing_golfer = outing_golfers(:jeremiah_stump_peninsula_2018)
    @team = Team.new(outing_golfer_id: @outing_golfer.id, team_date: Time.now)
  end

  it "should be valid" do
    expect(@team.valid?).to be_truthy
  end

  it "should be invalid when outing golfer is blank" do
    @team.outing_golfer_id = ""
    expect(@team.valid?).to be_falsey
  end

  it "should be invalid when team date is blank" do
    @team.team_date = ""
    expect(@team.valid?).to be_falsey
  end

end
