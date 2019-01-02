class Lodging < ApplicationRecord
  belongs_to :lodging_type

  validates(:room, presence: true)
end
