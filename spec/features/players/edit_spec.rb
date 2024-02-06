require 'rails_helper'

RSpec.describe "Player's Edit Page" do
  describe "when user visits" do
    let!(:campaign1) {DndCampaign.create!(name: "Kingmaker", setting: "Stolen Lands", active_campaign: true, sessions: 18)}
    let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0, active_player: true)}
  
    describe "when user visits" do
      before do
        visit "/players/#{player1.id}/edit"
      end

      it 'displays player form with current player info' do
        save_and_open_page
        expect(page.find_field("Name").value).to eq(player1.name)
        expect(page.find_field("Character Name").value).to eq(player1.character_name)
        expect(page.find_field("Sessions Missed").value.to_i).to eq(player1.sessions_missed)
        expect(page.find_field("Game Master").value).to eq(player1.game_master.to_s)
        expect(page.find_field("Active Player").value).to eq(player1.active_player.to_s)
      end
      
      it "updated form redirects to Players Show Page " do
        fill_in "Character Name", with: "Velma"
        select "false", from: "Game Master"
        
        click_button "Submit Changes"
        expect(current_path).to eq("/players/#{player1.id}")
        save_and_open_page
        expect(page).to have_content("Velma")
        expect(page).to have_content("false")
      end
    end
  end
end