class EmailLog < ApplicationRecord
  belongs_to :outing, optional: true
  belongs_to :golfer, optional: true
end
