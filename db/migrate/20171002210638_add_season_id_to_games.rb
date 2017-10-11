class AddSeasonIdToGames < ActiveRecord::Migration[5.1]
  def change
  	add_reference :games, :season, :index => true
  end
end
