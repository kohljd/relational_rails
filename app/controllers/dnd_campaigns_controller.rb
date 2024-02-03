class DndCampaignsController < ApplicationController
  def index
    @dnd_campaigns = DndCampaign.order_by_newest
  end

  def show
    @dnd_campaign = DndCampaign.find(params[:id])
  end
end