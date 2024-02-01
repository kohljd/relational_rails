class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :game_master
      t.string :character_name
      t.integer :sessions_missed
      t.references :dnd_campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
