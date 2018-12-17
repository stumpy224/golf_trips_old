class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :outing, foreign_key: true
      t.references :golfer, foreign_key: true
      t.date :attend_date
      t.integer :team_number
      t.integer :rank_number
      t.string :rank_letter
      t.integer :points_expected
      t.integer :points_actual

      t.timestamps
    end
  end
end
