class RemoveUserIdFromScores < ActiveRecord::Migration[6.1]
  def up
    remove_column :scores, :user_id
  end

  def down
    add_column :scores, :user_id, :integer
  end
end
