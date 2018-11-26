class User < ApplicationRecord
  before_save {self.email.downcase!}
  validates(:first_name, presence: true)
  validates(:last_name, presence: true)
  validates(:email, presence: true, uniqueness: {case_sensitive: false})
  validates(:password, presence: true, length: {minimum: 6}, confirmation: true,
            if: Proc.new do |user|
              user.password.present?
            end
  )
  validates(:password_confirmation, length: {minimum: 6},
            if: Proc.new do |user|
              user.password.present?
            end
  )
  validates_format_of :email, :with => /([^\s;*'"():!]{1,})([@]{1,1})([^\s;*'"():!]{1,})([.]{1,1})([\w]{2,})/
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
