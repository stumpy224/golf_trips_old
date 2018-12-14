ActiveAdmin.register Hole do
  belongs_to :course

  permit_params :course_id, :number, :par, :handicap
end
