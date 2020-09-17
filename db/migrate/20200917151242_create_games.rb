class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :publisher
      t.string :developer
      t.string :release_date
      t.timestamps null: false
    end
  end
end
