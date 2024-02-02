class DndCampaignPlayersController < ApplicationController
  def index
    @dnd_campaign = DndCampaign.find(params[:id])
    @players = @dnd_campaign.players
  end
end