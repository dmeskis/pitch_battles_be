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

ActiveRecord::Schema.define(version: 2018_12_19_202243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "total_duration"
    t.integer "level_one_duration"
    t.integer "level_two_duration"
    t.integer "level_three_duration"
    t.integer "level_four_duration"
    t.integer "remaining_life"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "klass_games", force: :cascade do |t|
    t.bigint "klass_id"
    t.bigint "games_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["games_id"], name: "index_klass_games_on_games_id"
    t.index ["klass_id"], name: "index_klass_games_on_klass_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name"
    t.string "class_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_klasses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_user_klasses_on_klass_id"
    t.index ["user_id"], name: "index_user_klasses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name", limit: 32
    t.string "last_name", limit: 32
    t.integer "role", default: 0
    t.string "password_digest"
    t.integer "avatar", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "users"
  add_foreign_key "klass_games", "games", column: "games_id"
  add_foreign_key "klass_games", "klasses"
  add_foreign_key "user_klasses", "klasses"
  add_foreign_key "user_klasses", "users"
end
