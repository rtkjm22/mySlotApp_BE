class AddUniqueUserIdToUsers < ActiveRecord::Migration[6.1]
  # def down
  #   add_column :users, :user_id, :integer, limit: 10, null: false
  #   add_index :users, :user_id, unique: true
  # end

  # def up
  #   remove_index :users, :user_id
  #   remove_colum :users, :user_id
  # end
end
