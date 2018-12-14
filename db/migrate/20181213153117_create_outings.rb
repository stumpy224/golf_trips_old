class CreateOutings < ActiveRecord::Migration[5.2]
  def change
    create_table :outings do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
