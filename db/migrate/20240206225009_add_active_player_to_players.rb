class AddActivePlayerToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :active_player, :boolean
  end
end
