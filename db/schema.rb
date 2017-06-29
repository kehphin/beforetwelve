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

ActiveRecord::Schema.define(version: 20170604222319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_id"
    t.boolean "master_checkin", default: false
    t.boolean "plusone_checkin", default: false
    t.index ["guest_id"], name: "index_check_ins_on_guest_id"
    t.index ["user_id"], name: "index_check_ins_on_user_id"
    t.index ["venue_id"], name: "index_check_ins_on_venue_id"
  end

  create_table "guestlists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_guestlists_on_user_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.boolean "checked_in", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "plusone", default: false
  end

  create_table "masterlists", force: :cascade do |t|
    t.string "name"
  end

  create_table "referrals", force: :cascade do |t|
    t.string "status"
    t.bigint "referrer_id"
    t.bigint "referree_id"
    t.index ["referree_id"], name: "index_referrals_on_referree_id"
    t.index ["referrer_id"], name: "index_referrals_on_referrer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "referral_code"
    t.boolean "superuser", default: false
    t.string "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "setup_completed"
    t.string "email"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  add_foreign_key "check_ins", "guests"
  add_foreign_key "check_ins", "users"
  add_foreign_key "check_ins", "venues"
  add_foreign_key "guestlists", "users"
end
