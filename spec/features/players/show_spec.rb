require 'rails_helper'
# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes
# (data from each column that is on the child table)

RSpec.describe "Players Show Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign2.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}

  describe "show page" do
    before(:each) do
      visit "/players/#{player1.id}"
    end
    
    it "displays player name" do
      save_and_open_page
      expect(page).to have_content(player1.name)
      expect(page).to_not have_content(player2.name)
    end
    
    it "displays if player is the gm" do
      expect(page).to have_content(player1.game_master)
      expect(page).to_not have_content(player2.game_master)
    end
    
    it "displays player's character name" do
      expect(page).to have_content(player1.character_name)
      expect(page).to_not have_content(player2.character_name)
    end
    
    it "displays player's missed session count" do
      expect(page).to have_content(player1.sessions_missed)
      expect(page).to_not have_content(player2.sessions_missed)
    end
  end
end