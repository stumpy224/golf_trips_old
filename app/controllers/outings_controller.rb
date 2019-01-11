class OutingsController < ApplicationController
  def show
    @outing = Outing.find(params[:id])
    @outing_golfers = OutingGolfer.includes(:golfer).where(outing_id: @outing.id)
    @outing_golfers_lodgings = @outing_golfers.includes(:lodging).group(:lodging_id).order("lodgings.sort_order", "golfers.last_name")
    @teams_overall = get_overall_stats_by_outing(@outing.id)
  end
end