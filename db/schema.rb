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

ActiveRecord::Schema.define(version: 20170919071202) do

  create_table "gifts", force: :cascade do |t|
    t.string   "lottery_code"
    t.integer  "seq"
    t.string   "name"
    t.integer  "start_cnt"
    t.string   "image_l_url"
    t.string   "image_m_url"
    t.string   "image_s_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "lotteries", force: :cascade do |t|
    t.string   "code"
    t.string   "owner_code"
    t.string   "title"
    t.datetime "draw_time"
    t.integer  "redraw_range"
    t.boolean  "nonres_redraw"
    t.datetime "end_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "code"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "lottery_code"
    t.integer  "seq"
    t.string   "token"
    t.integer  "gift_seq",     default: 0
    t.boolean  "act_flg",      default: true
    t.string   "status",       default: "0"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
