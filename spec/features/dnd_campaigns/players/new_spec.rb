require 'rails_helper'

RSpec.describe "DnD Campaign's New Player Page" do
  describe "when user visits" do
    let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}

    before do
      visit "/dnd_campaigns/#{campaign1.id}/players/new"
    end

    it 'displays new player form' do
      save_and_open_page
      expect(page).to have_field("Name")
      expect(page).to have_field("Character Name")
      expect(page).to have_field("Sessions Missed")
      expect(page).to have_select("Game Master", with_options: ["select", "true", "false"])
    end
    
    it "completed form redirects to DnD Campaign's Players Index" do
      fill_in "Name", with: "Samantha"
      fill_in "Character Name", with: "Daphne"
      fill_in "Sessions Missed", with: 4
      select "false", from: "Game Master"
      
      click_button "Create Player"
      expect(current_path).to eq("/dnd_campaigns/#{campaign1.id}/players")
      save_and_open_page
      expect(page).to have_content("Samantha")
    end
  end
end