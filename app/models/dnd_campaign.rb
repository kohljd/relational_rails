class DndCampaign < ApplicationRecord
  has_many :players

  def self.order_by_newest
    order(created_at: :desc)
  end

  def sort_players_alphabetically
    self.players.order(:name)
  end

  def player_count
    self.players.count
  end
end