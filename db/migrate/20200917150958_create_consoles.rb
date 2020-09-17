class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.string :name
      t.string :manufacturer
      t.string :release_date
      t.timestamps null: false
    end
  end
end
