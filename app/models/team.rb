class Team < ApplicationRecord
  belongs_to :outing_golfer

  has_many :scores, dependent: :destroy
  accepts_nested_attributes_for :scores, allow_destroy: true

  validates(:team_date, presence: true)
end
