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

ActiveRecord::Schema.define(version: 20160824073604) do

  create_table "astro_objects", force: :cascade do |t|
    t.text     "name"
    t.date     "date"
    t.time     "time"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chains", force: :cascade do |t|
    t.text     "kind"
    t.text     "code"
    t.binary   "image"
    t.text     "comment"
    t.integer  "astro_object_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "septener",        default: false
    t.boolean  "sun_retro"
    t.integer  "sun_weigth"
    t.integer  "sun_center"
    t.integer  "sun_relation"
    t.boolean  "moo_retro"
    t.integer  "moo_weigth"
    t.integer  "moo_center"
    t.integer  "moo_relation"
    t.boolean  "mer_retro"
    t.integer  "mer_weigth"
    t.integer  "mer_center"
    t.integer  "mer_relation"
    t.boolean  "ven_retro"
    t.integer  "ven_weigth"
    t.integer  "ven_center"
    t.integer  "ven_relation"
    t.boolean  "mar_retro"
    t.integer  "mar_weigth"
    t.integer  "mar_center"
    t.integer  "mar_relation"
    t.boolean  "jup_retro"
    t.integer  "jup_weigth"
    t.integer  "jup_center"
    t.integer  "jup_relation"
    t.boolean  "sat_retro"
    t.integer  "sat_weigth"
    t.integer  "sat_center"
    t.integer  "sat_relation"
    t.boolean  "ura_retro"
    t.integer  "ura_weigth"
    t.integer  "ura_center"
    t.integer  "ura_relation"
    t.boolean  "nep_retro"
    t.integer  "nep_weigth"
    t.integer  "nep_center"
    t.integer  "nep_relation"
    t.boolean  "plu_retro"
    t.integer  "plu_weigth"
    t.integer  "plu_center"
    t.integer  "plu_relation"
  end

  add_index "chains", ["astro_object_id"], name: "index_chains_on_astro_object_id"

end
