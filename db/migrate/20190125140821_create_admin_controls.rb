class CreateAdminControls < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_controls do |t|
      t.string :name
      t.text :description
      t.string :value

      t.timestamps
    end
  end
end
