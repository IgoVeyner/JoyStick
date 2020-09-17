class CreateGamesConsoles < ActiveRecord::Migration
  def change
    create_table :games_consoles do |t|
      t.integer :game_id
      t.integer :console_id
      t.timestamps null: false
    end
  end
end
