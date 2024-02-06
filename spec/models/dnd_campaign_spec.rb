require 'rails_helper'

RSpec.describe DndCampaign, type: :model do
  describe "relationships" do
    it {should have_many :players}
  end

  describe "instance methods" do
    let!(:campaign1) {DndCampaign.create!(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15)}
    let!(:player1) {campaign1.players.create!(name: "Jenna", game_master: true, character_name: "NPCs", sessions_missed: 0)}
    let!(:player2) {campaign1.players.create!(name: "Amy", game_master: false, character_name: "Francis", sessions_missed: 5)}
    
    it "counts players" do
      expect(campaign1.player_count).to eq(2)
    end

    it "sorts players alphabetically" do
      expect(campaign1.sort_players_alphabetically).to eq([player2, player1])
    end
  end
end