class AddIsBoardMemberToGolfers < ActiveRecord::Migration[5.2]
  def change
    add_column :golfers, :is_board_member, :boolean
  end
end
