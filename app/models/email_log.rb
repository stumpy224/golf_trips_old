class EmailLog < ApplicationRecord
  belongs_to :outing, optional: true
  belongs_to :golfer, optional: true

  validates(:template, presence: true)
  validates(:subject, presence: true)
  validates(:sent_to, presence: true)
end
