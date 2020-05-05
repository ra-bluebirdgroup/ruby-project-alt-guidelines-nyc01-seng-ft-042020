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

ActiveRecord::Schema.define(version: 5) do

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "dataQualityGrade"
    t.integer "positive"
    t.integer "negative"
    t.integer "recovered"
    t.datetime "lastUpdateEt"
    t.integer "death"
    t.integer "totalTestResults"
  end

  create_table "usas", force: :cascade do |t|
    t.string "name"
    t.integer "positive"
    t.integer "negative"
    t.integer "pending"
    t.integer "hospitalizedCurrently"
    t.integer "hospitalizedCumulative"
    t.integer "inIcuCurrently"
    t.integer "inIcuCumulative"
    t.integer "onVentilatorCurrently"
    t.integer "onVentilatorCumulative"
    t.integer "recovered"
    t.integer "death"
    t.integer "hospitalized"
    t.integer "totalTestResults"
  end

  create_table "user_state_records", force: :cascade do |t|
    t.integer "user_id"
    t.integer "state_id"
  end

  create_table "user_usa_records", force: :cascade do |t|
    t.integer "user_id"
    t.integer "usa_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
