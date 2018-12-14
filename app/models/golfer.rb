class Golfer < ApplicationRecord
  before_save { email.downcase! }
  validates(:first_name, presence: true)
  validates(:last_name, presence: true)
  validates(:email, presence: true, uniqueness: {case_sensitive: false})
  validates_format_of :email, :with => /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def full_name_with_nickname
    nickname = "(#{self.nickname})"
    self.nickname.blank? ? full_name : full_name + ' ' + nickname
  end
end
