require 'rails_helper'

RSpec.describe "DnD Campaigns Edit Page" do
  describe "when user visits" do
    let!(:campaign1) {DndCampaign.create!(name: "Kingmaker", setting: "Stolen Lands", active_campaign: true, sessions: 18)}
    let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0, active_player: true)}
    let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5, active_player: true)}
  
    describe "when user visits" do
      before do
        visit "/dnd_campaigns/#{campaign1.id}/edit"
      end

      it 'displays dnd campaign form with current campaign info' do
        save_and_open_page
        expect(page.find_field("Name").value).to eq(campaign1.name)
        expect(page.find_field("Setting").value).to eq(campaign1.setting)
        expect(page.find_field("Sessions").value.to_i).to eq(campaign1.sessions)
        expect(page.find_field("Active Campaign").value).to eq(campaign1.active_campaign.to_s)
      end
      
      it "updated form redirects to DnD Campaign " do
        fill_in "Sessions", with: 20
        select "false", from: "Active Campaign"
        
        click_button "Submit Changes"
        expect(current_path).to eq("/dnd_campaigns/#{campaign1.id}")
        save_and_open_page
        expect(page).to have_content(20)
        expect(page).to have_content("false")
      end
    end
  end
end