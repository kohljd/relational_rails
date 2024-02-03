require 'rails_helper'

RSpec.describe DndCampaign, type: :model do
  describe "relationships" do
    it {should have_many :players}
  end
end