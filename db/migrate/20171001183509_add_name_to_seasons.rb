class AddNameToSeasons < ActiveRecord::Migration[5.1]
  def change
  	add_column :seasons, :season_id, :string
  end
end
