ActiveAdmin.register Hole do
  permit_params :course_id, :number, :par, :handicap
  belongs_to :course
end
