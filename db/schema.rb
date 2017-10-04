# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171002210638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", id: :serial, force: :cascade do |t|
    t.integer "home_score", null: false
    t.integer "away_score", null: false
    t.string "home_user", null: false
    t.string "away_user", null: false
    t.string "winner", null: false
    t.integer "home_penalty_score"
    t.integer "away_penalty_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reviewed", default: false
    t.string "reviewer"
    t.string "submitter"
    t.boolean "approved", default: false
    t.string "game_id"
    t.bigint "season_id"
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "league_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "league_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_members_on_league_id"
    t.index ["user_id"], name: "index_league_members_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.string "password", null: false
    t.string "sport", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.string "status", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "season_id"
    t.index ["league_id"], name: "index_seasons_on_league_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", null: false
    t.integer "win_count", default: 0, null: false
    t.integer "loss_count", default: 0, null: false
    t.integer "goals_for", default: 0, null: false
    t.integer "goals_against", default: 0, null: false
    t.integer "points", default: 0, null: false
    t.integer "game_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tie_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
