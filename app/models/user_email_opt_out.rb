class UserEmailOptOut < ApplicationRecord
  belongs_to :user

  validates(:user_id, presence: true)
  validates(:email_template, presence: true)
end
