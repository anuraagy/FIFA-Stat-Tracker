class AddGameIdToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :game_id, :string
  end
end
