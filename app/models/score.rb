class Score < ApplicationRecord
  belongs_to :team
  belongs_to :hole
end
