class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_create :create_activation_digest
  before_save :downcase_email
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

  def is_activated?
    self.is_activated
  end

  def is_admin?
    AdminUser.find_by(email: self.email).present?
  end

  def is_authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def is_password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def activate
    update_columns(is_activated: true, activated_at: Time.zone.now, activation_digest: nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def downcase_email
    self.email = email.downcase
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

end
