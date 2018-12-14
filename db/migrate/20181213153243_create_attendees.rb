class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :outing, foreign_key: true
      t.references :golfer, foreign_key: true
      t.date :attend_date

      t.timestamps
    end
  end
end
