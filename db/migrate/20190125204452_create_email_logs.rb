class CreateEmailLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :email_logs do |t|
      t.string :template
      t.string :subject
      t.text :body
      t.string :sent_to
      t.references :outing, foreign_key: true
      t.references :golfer, foreign_key: true

      t.timestamps
    end
  end
end
