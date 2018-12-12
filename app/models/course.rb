class Course < ApplicationRecord
  validates(:name, presence: true)
  validates(:address, presence: true)
  validates(:phone, presence: true)

  has_many :holes, dependent: :destroy

  accepts_nested_attributes_for :holes
end
