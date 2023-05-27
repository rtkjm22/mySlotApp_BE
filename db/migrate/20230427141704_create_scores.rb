class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :play_count
      t.date :last_played
      t.float :win_rate
      t.integer :coin
      t.bigint :unique_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
