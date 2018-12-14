class Hole < ApplicationRecord
  belongs_to :course

  validates(:course_id, presence: true)
  validates(:number, presence: true)
  validates(:par, presence: true)
end
