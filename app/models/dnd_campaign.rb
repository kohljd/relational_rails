class DndCampaign < ApplicationRecord
  has_many :players

  def self.order_by_newest
    order(created_at: :desc)
  end
end