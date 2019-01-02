class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :team, foreign_key: true
      t.references :hole, foreign_key: true
      t.integer :strokes
      t.integer :points

      t.timestamps
    end
  end
end
