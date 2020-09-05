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

ActiveRecord::Schema.define(version: 2020_09_05_020549) do

  create_table "ads", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "price"
    t.integer "status"
    t.integer "product_category_id", null: false
    t.integer "company_employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_employee_id"], name: "index_ads_on_company_employee_id"
    t.index ["product_category_id"], name: "index_ads_on_product_category_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "legal_name"
    t.string "cnpj"
    t.string "address"
    t.string "social_media"
    t.string "domain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "company_employees", force: :cascade do |t|
    t.string "full_name"
    t.date "date_of_birth"
    t.string "position"
    t.string "departament"
    t.string "cpf"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_employees_on_company_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_employee_id"
    t.index ["company_employee_id"], name: "index_users_on_company_employee_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ads", "company_employees"
  add_foreign_key "ads", "product_categories"
  add_foreign_key "company_employees", "companies"
  add_foreign_key "users", "company_employees"
end
