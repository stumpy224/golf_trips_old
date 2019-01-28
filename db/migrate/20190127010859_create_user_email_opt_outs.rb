class CreateUserEmailOptOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_email_opt_outs do |t|
      t.references :user, foreign_key: true
      t.string :email_template

      t.timestamps
    end
  end
end
