require 'rails_helper'

RSpec.describe "DnD Campaigns New Page" do
  describe "when user visits" do
    before do
      visit "/dnd_campaigns/new"
    end

    it 'displays new dnd campaign form' do
      save_and_open_page
      expect(page).to have_field("Name")
      expect(page).to have_field("Setting")
      expect(page).to have_field("Sessions")
      expect(page).to have_select("active_campaign", with_options: ["select", "true", "false"])
    end
    
    it "completed form redirects to DnD Campaign Index" do
      fill_in "Name", with: "Abomination Vaults"
      fill_in "Setting", with: "Otari Dungeons"
      fill_in "Sessions", with: 8 
      select "true", from: "active_campaign"
      
      click_button "Create DnD Campaign"
      expect(current_path).to eq("/dnd_campaigns")
      expect(page).to have_content("Abomination Vaults")
    end
  end
end