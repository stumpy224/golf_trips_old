class Attendee < ApplicationRecord
  belongs_to :outing
  belongs_to :golfer

  validates(:outing_id, presence: true)
  validates(:golfer_id, presence: true)
  validates(:attend_date, presence: true)
end
