class Outing < ApplicationRecord
  belongs_to :course

  has_many :outing_golfers, dependent: :destroy
  accepts_nested_attributes_for :outing_golfers, allow_destroy: true

  validates(:course_id, presence: true)
  validates(:name, presence: true)
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)

  def get_dates
    (self.start_date..self.end_date).to_a
  end
end
