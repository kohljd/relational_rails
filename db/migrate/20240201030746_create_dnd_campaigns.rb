class CreateDndCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :dnd_campaigns do |t|
      t.string :name
      t.string :setting
      t.boolean :active_campaign
      t.integer :sessions

      t.timestamps
    end
  end
end
