require 'rails_helper'

RSpec.describe "DnD Campaigns Show Page" do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0, active_player: true)}
  let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5, active_player: true)}

  describe "when user visits" do
    before(:each) do
      visit "/dnd_campaigns/#{campaign1.id}"
    end

    describe "displays campaign's attributes" do
      it "name" do
        save_and_open_page
        expect(page).to have_content(campaign1.name)
        expect(page).to_not have_content(campaign2.name)
      end

      it "setting" do
        expect(page).to have_content(campaign1.setting)
        expect(page).to_not have_content(campaign2.setting)
      end

      it "if active" do
        expect(page).to have_content(campaign1.active_campaign)
        expect(page).to_not have_content(campaign2.active_campaign)
      end

      it "session count" do
        expect(page).to have_content(campaign1.sessions)
        expect(page).to_not have_content(campaign2.sessions)
      end
    end

    it "displays campaign's players count" do
      expect(page).to have_content(campaign1.player_count)
      expect(page).to_not have_content(campaign2.player_count)
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

      it "dnd campaign's players index" do
        expect(page).to have_link("#{campaign1.name}'s Player List")

        click_link "#{campaign1.name}'s Player List"
        expect(current_path).to eq("/dnd_campaigns/:id/players")
      end

      it "dnd campaign's edit" do
        expect(page).to have_link("Update #{campaign1.name}'s Campaign Info")

        click_link "Update #{campaign1.name}'s Campaign Info"
        expect(current_path).to eq("/dnd_campaigns/:id/edit")
      end
    end
  end
end