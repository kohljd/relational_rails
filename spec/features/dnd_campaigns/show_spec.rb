require 'rails_helper'

RSpec.describe "DnD Campaigns Show Page" do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}

  describe "when user visits" do
    before(:each) do
      visit "/dnd_campaigns/#{campaign1.id}"
    end

    it "displays the campaign name" do
      save_and_open_page
      expect(page).to have_content(campaign1.name)
      expect(page).to_not have_content(campaign2.name)
    end

    it "displays the campaign's setting" do
      expect(page).to have_content(campaign1.setting)
      expect(page).to_not have_content(campaign2.setting)
    end

    it "displays if campaign's active" do
      expect(page).to have_content(campaign1.active_campaign)
      expect(page).to_not have_content(campaign2.active_campaign)
    end

    it "displays campaign's session count" do
      expect(page).to have_content(campaign1.sessions)
      expect(page).to_not have_content(campaign2.sessions)
    end

    it "displays campaign's players count" do
      expect(page).to have_content(campaign1.player_count)
      expect(page).to_not have_content(campaign2.player_count)
    end
  end
end