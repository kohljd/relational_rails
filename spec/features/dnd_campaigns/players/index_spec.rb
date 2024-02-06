require 'rails_helper'

RSpec.describe "DnD Campaign's Players Index" do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign1.players.create!(name: "Amy", game_master: true, character_name: "Francis", sessions_missed: 5)}
  let!(:player3) {campaign2.players.create!(name: "Sean", game_master: false, character_name: "Alfred", sessions_missed: 8)}

  describe "when user visits" do
    before (:each) do
      visit "/dnd_campaigns/#{campaign1.id}/players"
    end

    it "displays the campaign's name" do
      save_and_open_page
      expect(page).to have_content(campaign1.name)
      expect(page).to_not have_content(campaign2.name)
    end

    it "displays campaign's player list" do
      expect(page).to have_content(player1.name)
      expect(page).to have_content(player2.name)
      expect(page).to_not have_content(player3.name)
    end

    describe "displays each campaign player's attributes" do
      it "players' gm status" do
        within "#player_#{player1.id}" do
          expect(page).to have_content(player1.game_master)
        end

        within "#player_#{player2.id}" do
          expect(page).to have_content(player2.game_master)
        end
      end
      
      it "players' character name" do
        expect(page).to have_content(player1.character_name)
        expect(page).to have_content(player2.character_name)
        expect(page).to_not have_content(player3.character_name)
      end
      
      it "players' missed session count" do
        expect(page).to have_content(player1.sessions_missed)
        expect(page).to have_content(player2.sessions_missed)
        expect(page).to_not have_content(player3.sessions_missed)
      end
    end

    describe "displays links that go to" do
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

      it "create new player" do
        expect(page).to have_link("Create New Player")

        click_link "Create New Player"
        expect(current_path).to eq("/dnd_campaigns/#{campaign1.id}/players/new")
      end
    end

    describe "can sort players alphabetically" do
      it "displays link to alphabetically sort" do
        expect(page).to have_link("Sort Players Alphabetically")

        click_link "Sort Players Alphabetically"
        expect(current_path).to eq("/dnd_campaigns/#{campaign1.id}/players")
      end

      it "reloads page to display players alphabetically" do
        expect(player1.name).to appear_before(player2.name)

        click_link "Sort Players Alphabetically"
        save_and_open_page
        expect(player2.name).to appear_before(player1.name)
      end
    end
  end
end