ActiveAdmin.register Attendee do
  belongs_to :outing
  belongs_to :golfer

  permit_params :outing_id, :golfer_id, :attend_date, :team_number, :rank_number, :rank_letter, :points_expected, :points_actual

  controller do
    def destroy
      Attendee.destroy(params[:id])
      head :ok # return 200
    end
  end
end
