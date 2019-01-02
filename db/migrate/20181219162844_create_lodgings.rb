class CreateLodgings < ActiveRecord::Migration[5.2]
  def change
    create_table :lodgings do |t|
      t.references :lodging_type, foreign_key: true
      t.string :room
      t.integer :sort_order

      t.timestamps
    end
  end
end
