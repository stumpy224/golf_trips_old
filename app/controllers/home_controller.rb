class HomeController < ApplicationController
  def index
    if logged_in?
      @golfer = Golfer.find_by_email(current_user.email)
      @outing_golfer_records = OutingGolfer.where(golfer_id: @golfer.id)
      @outings = Outing.where(id: @outing_golfer_records.pluck(:outing_id)).order(start_date: :desc)
    end
  end
end
