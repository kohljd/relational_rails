class DndCampaignsController < ApplicationController
  def index
    @dnd_campaigns = DndCampaign.all
  end
end