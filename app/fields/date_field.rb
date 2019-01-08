require "administrate/field/base"

class DateField < Administrate::Field::Base
  def to_s
    # formatted as => Sun May 20, 2018
    data.strftime("%a %b %d, %Y")
  end
end
