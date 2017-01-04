class AddReviewToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :reviewed, :boolean , :default => false
  end
end
