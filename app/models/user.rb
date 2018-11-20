class User < ApplicationRecord
  before_save { email.downcase! }
  validates(:first_name, presence: true)
  validates(:last_name, presence: true)
  validates(:email, presence: true, uniqueness: { case_sensitive: false })
  validates(:password, presence: true, length: { minimum: 6 })
  validates_format_of :email, :with => /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/
  has_secure_password
end
