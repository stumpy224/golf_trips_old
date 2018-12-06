class ChangePhoneToBeStringInGolfers < ActiveRecord::Migration[5.2]
  def change
    change_column :golfers, :phone, :string
  end
end
