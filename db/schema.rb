# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_06_225009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dnd_campaigns", force: :cascade do |t|
    t.string "name"
    t.string "setting"
    t.boolean "active_campaign"
    t.integer "sessions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.boolean "game_master"
    t.string "character_name"
    t.integer "sessions_missed"
    t.bigint "dnd_campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_player"
    t.index ["dnd_campaign_id"], name: "index_players_on_dnd_campaign_id"
  end

  add_foreign_key "players", "dnd_campaigns"
end
