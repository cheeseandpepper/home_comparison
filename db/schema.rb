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

ActiveRecord::Schema.define(version: 20170312015009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feature_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "weight"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.integer  "score"
    t.integer  "weight"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "house_id"
    t.integer  "feature_type_id"
  end

  create_table "house_images", force: :cascade do |t|
    t.integer "house_id"
    t.string  "url"
  end

  create_table "houses", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.integer  "price"
    t.string   "address"
    t.string   "link"
    t.string   "image_url"
    t.integer  "beds"
    t.float    "baths"
    t.float    "score"
    t.float    "max_score"
    t.string   "city_state_zip"
    t.string   "house_ref"
    t.text     "page"
    t.integer  "lot_size"
    t.integer  "house_size"
  end

end
