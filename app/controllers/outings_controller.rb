class OutingsController < ApplicationController
  before_action :authenticate_user_attendance

  def show
    @outing = Outing.find(params[:id])
    @outing_golfers = OutingGolfer.includes(:golfer).where(outing_id: @outing.id)
    @outing_golfers_lodgings = @outing_golfers.includes(:lodging).group(:lodging_id).order("lodgings.sort_order", "golfers.last_name")
    @teams_overall = get_overall_stats_by_outing(@outing.id)
  end

  private

  def authenticate_user_attendance
    golfer = Golfer.find_by_email(current_user.email)

    if golfer.nil?
      flash[:error] = "Please contact the Site Administrator"
      redirect_to root_path
    end

    # golfer found, determine if they attended the outing in question
    outing_ids = OutingGolfer.where(golfer_id: golfer.id).pluck(:outing_id)

    unless outing_ids.include?(params[:id].to_i)
      flash[:warning] = "Could not find Outing"
      redirect_to root_path
    end
  end
end
