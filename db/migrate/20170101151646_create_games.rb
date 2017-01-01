class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :home_score,          :null => false
      t.integer :away_score,          :null => false
      t.string  :home_user,           :null => false
      t.string  :away_user,           :null => false
      t.string  :winner,              :null => false
      t.integer :home_penalty_score
      t.integer :away_penalty_score
      t.timestamps
    end
  end
end
