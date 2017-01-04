class AddReviewerToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :reviewer, :string
  end
end
