class Golfer < ApplicationRecord
  before_save { email.downcase! }
  validates(:first_name, presence: true)
  validates(:last_name, presence: true)
  validates(:email, presence: true, uniqueness: {case_sensitive: false})
  validates_format_of :email, :with => /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/
end
