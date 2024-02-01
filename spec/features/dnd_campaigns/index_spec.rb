require 'rails_helper'
# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

RSpec.describe "DnD Campaigns Index Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}

  describe "index page" do
    it 'displays all dnd campaign names' do
      visit "/dnd_campaigns"

      expect(page).to have_content(campaign1.name)
      expect(page).to have_content(campaign2.name)
    end
  end
end