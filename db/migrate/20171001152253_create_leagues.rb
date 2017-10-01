class CreateLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.string :name,         :null => false
      t.string :display_name, :null => false
      t.string :password,     :null => false
      t.string :sport,        :null => false

      t.timestamps
    end
  end
end
