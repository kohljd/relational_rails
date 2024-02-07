class DndCampaignsController < ApplicationController
  def index
    @dnd_campaigns = DndCampaign.order_by_newest
  end

  def new; end

  def create
    dnd_campaign = DndCampaign.create(dnd_campaign_params)
    redirect_to "/dnd_campaigns"
  end

  def show
    @dnd_campaign = DndCampaign.find(params[:id])
  end

  def edit
    @dnd_campaign = DndCampaign.find(params[:id])
  end

  def update
    dnd_campaign = DndCampaign.find(params[:id])
    dnd_campaign.update(dnd_campaign_params)
    redirect_to "/dnd_campaigns/#{dnd_campaign.id}"
  end

  private
    def dnd_campaign_params
      params.require("dnd_campaign").permit(:name, :setting, :sessions, :active_campaign)
    end
end