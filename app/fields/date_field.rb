require "administrate/field/base"

class DateField < Administrate::Field::Base
  def to_s
    data.strftime("%a %b %d, %Y")
  end
end
