require 'rails_helper'

RSpec.describe "Players Index Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}

  describe "when user visits" do
    before(:each) do
      visit "/players"
    end
    
    describe "displays players' attributes" do
      it "players' names" do
        expect(page).to have_content(player1.name)
        expect(page).to have_content(player2.name)
      end
      
      it "players' gm status" do
        expect(page).to have_content(player1.game_master)
        expect(page).to have_content(player2.game_master)
      end
      
      it "players' character's names" do
        expect(page).to have_content(player1.character_name)
        expect(page).to have_content(player2.character_name)
      end
      
      it "players' missed session count" do
        expect(page).to have_content(player1.sessions_missed)
        expect(page).to have_content(player2.sessions_missed)
      end
    end

    describe "displays links to" do
      it "players index" do
        expect(page).to have_link("Players List")
      end

      it "dnd campaigns index" do
        expect(page).to have_link("DnD Campaigns List")
      end
    end
  end
end