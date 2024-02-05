class DndCampaignsController < ApplicationController
  def index
    @dnd_campaigns = DndCampaign.order_by_newest
  end

  def new; end

  def create
    DndCampaign.create(dnd_campaign_params)
    redirect_to "/dnd_campaigns"
  end

  def show
    @dnd_campaign = DndCampaign.find(params[:id])
  end

  private
    def dnd_campaign_params
      params.permit(:name, :setting, :sessions, :active_campaign)
    end
end