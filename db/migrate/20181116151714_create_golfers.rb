class CreateGolfers < ActiveRecord::Migration[5.2]
  def change
    create_table :golfers do |t|
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :email
      t.integer :phone
      t.boolean :is_active

      t.timestamps
    end
  end
end
