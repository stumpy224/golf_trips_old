class CreateHoles < ActiveRecord::Migration[5.2]
  def change
    create_table :holes do |t|
      t.integer :course_id
      t.integer :number
      t.integer :par
      t.integer :handicap

      t.timestamps
    end
    add_index :holes, :course_id
  end
end
