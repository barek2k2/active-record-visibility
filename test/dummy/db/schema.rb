# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160306095107) do

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visibilities", force: :cascade do |t|
    t.integer  "visible_id"
    t.string   "visible_type"
    t.string   "visible_attribute"
    t.boolean  "is_visible",        default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "visibilities", ["visible_id", "visible_type", "visible_attribute"], name: "index_visible_attr"
  add_index "visibilities", ["visible_id", "visible_type"], name: "index_visible"

end
