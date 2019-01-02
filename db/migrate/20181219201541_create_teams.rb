class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :outing_golfer, foreign_key: true
      t.integer :team_number
      t.integer :rank_number
      t.string :rank_letter
      t.integer :points_expected
      t.integer :points_actual
      t.integer :points_plus_minus
      t.date :team_date

      t.timestamps
    end
  end
end
