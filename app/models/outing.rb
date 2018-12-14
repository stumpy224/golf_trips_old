class Outing < ApplicationRecord
  belongs_to :course

  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, allow_destroy: true

  validates(:course_id, presence: true)
  validates(:name, presence: true)
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)
end
