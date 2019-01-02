class OutingGolfer < ApplicationRecord
  belongs_to :outing
  belongs_to :golfer
  belongs_to :lodging, optional: true

  has_many :teams, dependent: :destroy
  accepts_nested_attributes_for :teams, allow_destroy: true
end
