class AddSubmitterToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :submitter, :string
  end
end
