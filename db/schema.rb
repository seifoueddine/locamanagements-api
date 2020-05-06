# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_05_211555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "label"
    t.text "description"
    t.string "service"
    t.boolean "status"
    t.datetime "start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.boolean "important"
    t.index ["contact_id"], name: "index_appointments_on_contact_id"
    t.index ["property_id"], name: "index_appointments_on_property_id"
    t.index ["slug_id"], name: "index_appointments_on_slug_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "first_phone"
    t.string "email"
    t.string "second_phone"
    t.string "roles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id", null: false
    t.index ["slug_id"], name: "index_contacts_on_slug_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "contract_type"
    t.text "contract_details"
    t.integer "payment_frequency_number"
    t.string "payment_frequency_name"
    t.datetime "payment_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "user_id", null: false
    t.integer "property_id", null: false
    t.index ["contact_id"], name: "index_contracts_on_contact_id"
    t.index ["slug_id"], name: "index_contracts_on_slug_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "target_type", null: false
    t.string "target_id", null: false
    t.text "data"
    t.bigint "notifier_id", null: false
    t.datetime "opened_at"
    t.boolean "read"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id", null: false
    t.index ["slug_id"], name: "index_notifications_on_slug_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id", null: false
    t.bigint "contact_id", null: false
    t.string "images", default: [], array: true
    t.string "property_type"
    t.integer "surface"
    t.string "address"
    t.string "wilaya"
    t.string "city"
    t.integer "owner_price"
    t.integer "agency_price"
    t.string "transaction_type"
    t.integer "nbr_of_pieces"
    t.boolean "is_furnished"
    t.boolean "is_equipped"
    t.boolean "has_elevator"
    t.integer "has_floors"
    t.integer "floor"
    t.boolean "has_garage"
    t.boolean "has_garden"
    t.boolean "has_swimming_pool"
    t.boolean "has_sanitary"
    t.text "description"
    t.index ["contact_id"], name: "index_properties_on_contact_id"
    t.index ["slug_id"], name: "index_properties_on_slug_id"
  end

  create_table "slugs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "slug_id"
    t.string "avatar"
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug_id"], name: "index_users_on_slug_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "appointments", "contacts"
  add_foreign_key "appointments", "properties"
  add_foreign_key "appointments", "slugs"
  add_foreign_key "appointments", "users"
  add_foreign_key "contacts", "slugs"
  add_foreign_key "contracts", "contacts"
  add_foreign_key "contracts", "slugs"
  add_foreign_key "contracts", "users"
  add_foreign_key "notifications", "slugs"
  add_foreign_key "properties", "contacts"
  add_foreign_key "properties", "slugs"
  add_foreign_key "users", "slugs"
end
