class Course < ApplicationRecord
  has_many :holes, dependent: :destroy
  accepts_nested_attributes_for :holes, allow_destroy: true

  validates(:name, presence: true)
  validates(:address, presence: true)
  validates(:phone, presence: true)
end
