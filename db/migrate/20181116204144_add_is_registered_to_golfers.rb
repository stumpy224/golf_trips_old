class AddIsRegisteredToGolfers < ActiveRecord::Migration[5.2]
  def change
    add_column :golfers, :is_registered, :boolean
  end
end
