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

ActiveRecord::Schema[7.1].define(version: 2024_05_16_121749) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adopters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "preference"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_adopters_on_user_id"
  end

  create_table "adoption_applications", force: :cascade do |t|
    t.bigint "adopter_id", null: false
    t.bigint "pet_id", null: false
    t.integer "status", default: 0
    t.date "application_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adopter_id"], name: "index_adoption_applications_on_adopter_id"
    t.index ["pet_id"], name: "index_adoption_applications_on_pet_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pet_id", null: false
    t.index ["pet_id"], name: "index_favorites_on_pet_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "pet_comments", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "user_id", null: false
    t.text "comment_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_comments_on_pet_id"
    t.index ["user_id"], name: "index_pet_comments_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "shelter_id", null: false
    t.string "name"
    t.string "species"
    t.string "breed"
    t.integer "age"
    t.string "size"
    t.string "gender"
    t.string "temperament"
    t.text "description"
    t.string "photo_url"
    t.integer "adoption_status", default: 0
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "website"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shelters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.boolean "approved", default: false
    t.string "username"
    t.string "location"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "adopters", "users"
  add_foreign_key "adoption_applications", "adopters"
  add_foreign_key "adoption_applications", "pets"
  add_foreign_key "favorites", "pets"
  add_foreign_key "favorites", "users"
  add_foreign_key "pet_comments", "pets"
  add_foreign_key "pet_comments", "users"
  add_foreign_key "pets", "shelters"
  add_foreign_key "shelters", "users"
end
