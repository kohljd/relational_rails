require 'rails_helper'
# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes
# (data from each column that is on the child table)

RSpec.describe "Players Index Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}

  describe "index page" do
    before(:each) do
      visit "/players"
    end
    
    it "displays all player names" do
      expect(page).to have_content(player1.name)
      expect(page).to have_content(player2.name)
    end
    
    it "displays if players are the gm" do
      expect(page).to have_content(player1.game_master)
      expect(page).to have_content(player2.game_master)
    end
    
    it "displays players' character's names" do
      expect(page).to have_content(player1.character_name)
      expect(page).to have_content(player2.character_name)
    end
    
    it "displays players' missed session count" do
      expect(page).to have_content(player1.sessions_missed)
      expect(page).to have_content(player2.sessions_missed)
    end
  end
end