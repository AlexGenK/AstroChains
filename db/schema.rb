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

ActiveRecord::Schema.define(version: 20160929181609) do

  create_table "astro_objects", force: :cascade do |t|
    t.text     "name"
    t.date     "date"
    t.time     "time"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "birthplace"
    t.text     "points"
  end

  create_table "chains", force: :cascade do |t|
    t.text     "kind"
    t.text     "comment"
    t.integer  "astro_object_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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
    t.text     "direction"
    t.text     "visualization"
    t.text     "center_style",    default: "elements"
  end

  add_index "chains", ["astro_object_id"], name: "index_chains_on_astro_object_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context"
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
