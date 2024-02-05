require 'rails_helper'

RSpec.describe "DnD Campaigns Index Page", type: :feature do
  let!(:campaign1) {DndCampaign.create!(name: "Mighty Nein", setting: "Castles", active_campaign: false, sessions: 152, created_at: DateTime.new(2021,12,5))}
  let!(:campaign2) {DndCampaign.create(name: "Ravenloft", setting: "Forgotten Realm", active_campaign: true, sessions: 15, created_at: DateTime.new(2023,2,1))}

  describe "when user visits" do
    before (:each) do
      visit "/dnd_campaigns"
    end

    it "displays all dnd campaign names" do
      save_and_open_page
      expect(page).to have_content(campaign1.name)
      expect(page).to have_content(campaign2.name)
    end

    it "displays campaigns by recently created" do
      expect(campaign2.name).to appear_before(campaign1.name)
    end

    it "displays date created next to campaign name" do
      expect(page).to have_content("#{campaign1.name} - #{campaign1.created_at}")
      expect(page).to have_content("#{campaign2.name} - #{campaign2.created_at}")
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

      it "create new dnd campaign" do
        expect(page).to have_link("Create New DnD Campaign")

        click_link "Create New DnD Campaign"
        expect(current_path).to eq("/dnd_campaigns/new")
      end
    end
  end
end