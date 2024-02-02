require 'rails_helper'
# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes
# (data from each column that is on the child table)

RSpec.describe "DnD Campaign's Players Index" do
  let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
  let!(:campaign2) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152)}
  let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
  let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}
  let!(:player3) {campaign2.players.create!(name: "Sean", game_master: false, character_name: "Alfred", sessions_missed: 8)}

  describe "when user visits a campaign's players show page" do
    before (:each) do
      visit "/dnd_campaigns/#{campaign1.id}/players"
    end

    it "displays the campaign's name" do
      save_and_open_page
      expect(page).to have_content(campaign1.name)
      expect(page).to_not have_content(campaign2.name)
    end

    it "displays campaign's players list" do
      expect(page).to have_content(player1.name)
      expect(page).to have_content(player2.name)
      expect(page).to_not have_content(player3.name)
    end

    describe "each campaign players' attributes" do
      it "displays if each comapign players is the gm" do
        # match(:first, :css, "div")#"#player_#{player1.id}" do
        # match(:first within(:css, "div")) do 
        within all(:css, "p")[0] do
          expect(page).to have_content(player1.game_master)
        end

        within all(:css, "p")[3] do
          expect(page).to have_content(player2.game_master)
        end
      end
      
      it "displays each comapign players' character name" do
        expect(page).to have_content(player1.character_name)
        expect(page).to have_content(player2.character_name)
        expect(page).to_not have_content(player3.character_name)
      end
      
      it "displays each campaign player's missed session count" do
        expect(page).to have_content(player1.sessions_missed)
        expect(page).to have_content(player2.sessions_missed)
        expect(page).to_not have_content(player3.sessions_missed)
      end
    end
  end
end