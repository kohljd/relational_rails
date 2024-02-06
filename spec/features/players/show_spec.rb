require 'rails_helper'

RSpec.describe "Players Show Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign2.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}

  describe "when user visits" do
    before(:each) do
      visit "/players/#{player1.id}"
    end
    
    describe "displays player's attributes" do
      it "name" do
        save_and_open_page
        expect(page).to have_content(player1.name)
        expect(page).to_not have_content(player2.name)
      end
      
      it "gm status" do
        expect(page).to have_content(player1.game_master)
        expect(page).to_not have_content(player2.game_master)
      end
      
      it "character name" do
        expect(page).to have_content(player1.character_name)
        expect(page).to_not have_content(player2.character_name)
      end
      
      it "missed session count" do
        expect(page).to have_content(player1.sessions_missed)
        expect(page).to_not have_content(player2.sessions_missed)
      end
    end

    describe "displays links to" do
      it "players index" do
        expect(page).to have_link("Players List")

        click_link "Players List"
        expect(current_path).to eq("/players")
      end

      it "dnd campaigns index" do
        expect(page).to have_link("DnD Campaigns List")

        click_link "DnD Campaigns List"
        expect(current_path).to eq("/dnd_campaigns")
      end

      it "player edit" do
        expect(page).to have_link("Update #{player1.name}'s Info")

        click_link "Update #{player1.name}'s Info"
        expect(current_path).to eq("/players/#{player1.id}/edit")
      end
    end
  end
end