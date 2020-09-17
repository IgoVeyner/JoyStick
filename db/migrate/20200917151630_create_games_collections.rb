class CreateGamesCollections < ActiveRecord::Migration
  def change
    create_table :games_collections do |t|
      t.integer :game_id
      t.integer :collection_id
      t.timestamps null: false
    end
  end
end
