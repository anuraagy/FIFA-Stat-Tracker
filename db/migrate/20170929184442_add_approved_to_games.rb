class AddApprovedToGames < ActiveRecord::Migration[5.1]
  def change
  	 add_column :games, :approved, :boolean , :default => false
  end
end
