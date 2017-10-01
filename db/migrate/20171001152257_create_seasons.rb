class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.timestamp  :start,  :null => false
      t.timestamp  :end,    :null => false
      t.string     :status, :null => false
      t.belongs_to :league, :null => false
      
      t.timestamps
    end
  end
end
