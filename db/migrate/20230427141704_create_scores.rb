class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.string :player_id, unique: true
      t.integer :play_time
      t.integer :play_count
      t.integer :game_currency
      t.date :last_played
      t.float :win_rate

      t.timestamps
    end
  end
end
