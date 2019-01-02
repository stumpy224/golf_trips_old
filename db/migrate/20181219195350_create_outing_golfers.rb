class CreateOutingGolfers < ActiveRecord::Migration[5.2]
  def change
    create_table :outing_golfers do |t|
      t.references :outing, foreign_key: true
      t.references :golfer, foreign_key: true
      t.references :lodging, foreign_key: true

      t.timestamps
    end
  end
end
