class DndCampaignsController < ApplicationController
  def index
    @dnd_campaigns = DndCampaign.all
  end

  def show
    @dnd_campaign = DndCampaign.find(params[:id])
  end
end