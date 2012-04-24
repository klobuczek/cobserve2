# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "cycles", :force => true do |t|
    t.integer "day_id",        :null => false
    t.integer "reading"
    t.boolean "contraception"
  end

  create_table "days", :force => true do |t|
    t.integer "user_id",                   :null => false
    t.date    "date",                      :null => false
    t.time    "time"
    t.boolean "first"
    t.float   "temperature"
    t.integer "intercourse"
    t.integer "mensing"
    t.integer "cervical_fluid_feeling"
    t.integer "cervical_fluid_appearance"
    t.integer "cervix_position"
    t.integer "cervix_opening"
    t.integer "cervix_texture"
    t.boolean "ovulation_pain"
    t.boolean "tender_breasts"
    t.boolean "fever"
    t.boolean "lack_of_sleep"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40,  :null => false
    t.string   "crypted_password",          :limit => 40,  :null => false
    t.string   "email",                     :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
