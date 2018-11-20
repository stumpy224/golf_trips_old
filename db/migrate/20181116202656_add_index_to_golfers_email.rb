class AddIndexToGolfersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :golfers, :email, unique: true
  end
end
