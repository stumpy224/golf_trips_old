class LodgingType < ApplicationRecord
  validates(:name, presence: true)
end
