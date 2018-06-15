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

ActiveRecord::Schema.define(version: 2018_06_15_222941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.decimal "lat"
    t.decimal "lng"
    t.text "place"
    t.string "budget_type"
    t.string "status", default: "submitted", null: false
    t.integer "votes_count", default: 0, null: false
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "approved", default: false, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tags_projects", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_tags_projects_on_project_id"
    t.index ["tag_id", "project_id"], name: "index_tags_projects_on_tag_id_and_project_id", unique: true
    t.index ["tag_id"], name: "index_tags_projects_on_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "projects", "categories"
  add_foreign_key "projects", "users"
  add_foreign_key "tags_projects", "projects"
  add_foreign_key "tags_projects", "tags"
end
