# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_14_155237) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breeders", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horses", force: :cascade do |t|
    t.string "name"
    t.integer "dam_id"
    t.integer "sire_id"
    t.string "thumbnail"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "registration_number"
    t.string "gender"
    t.string "color"
    t.integer "birth_year"
    t.integer "breeder_id"
    t.boolean "performance_records_available"
  end

end
