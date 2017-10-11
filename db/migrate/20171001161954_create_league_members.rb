class CreateLeagueMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :league_members do |t|
      t.belongs_to :user, :index => true
      t.belongs_to :league, :index => true
      t.string :role
      t.timestamps
    end
  end
end
