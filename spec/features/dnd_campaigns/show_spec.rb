require 'rails_helper'
# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes
# (data from each column that is on the parent table)

RSpec.describe "DnD Campaigns Show Page" do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}

  describe "when user visits show page" do
    before(:each) do
      visit "/dnd_campaigns/#{campaign1.id}"
    end

    it "displays the campaign name" do
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
  end
end