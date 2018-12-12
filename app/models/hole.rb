class Hole < ApplicationRecord
  validates(:course_id, presence: true)
  validates(:number, presence: true)
  validates(:par, presence: true)

  belongs_to :course
end
