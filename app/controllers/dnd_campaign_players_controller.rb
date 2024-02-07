class DndCampaignPlayersController < ApplicationController
  def index
    @dnd_campaign = DndCampaign.find(params[:id])
    
    if params[:sort] == "names_alphabetically" 
      @players = @dnd_campaign.sort_players_alphabetically
    else
      @players = @dnd_campaign.players
    end
  end

  def new
    @dnd_campaign = DndCampaign.find(params[:id])
  end

  def create
    dnd_campaign = DndCampaign.find(params[:id])
    player = dnd_campaign.players.create(player_params)
    redirect_to "/dnd_campaigns/#{dnd_campaign.id}/players"
  end

  private
    def player_params
      params.permit(:name, :character_name, :sessions_missed, :game_master, :active_player)
    end
end