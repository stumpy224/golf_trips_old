ActiveAdmin.register Attendee do
  belongs_to :outing
  belongs_to :golfer

  permit_params :outing_id, :golfer_id, :attend_date
end
