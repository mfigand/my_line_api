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

ActiveRecord::Schema.define(version: 2020_03_25_074157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "resource"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_roles_on_created_at"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource"], name: "index_roles_on_resource"
    t.index ["resource_id"], name: "index_roles_on_resource_id"
    t.index ["updated_at"], name: "index_roles_on_updated_at"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.date "date", null: false
    t.integer "protagonist_id"
    t.integer "teller_id", null: false
    t.integer "teller_title"
    t.integer "timeline_id", null: false
    t.jsonb "tags"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_stories_on_created_at"
    t.index ["date"], name: "index_stories_on_date"
    t.index ["description"], name: "index_stories_on_description"
    t.index ["protagonist_id"], name: "index_stories_on_protagonist_id"
    t.index ["tags"], name: "index_stories_on_tags", using: :gin
    t.index ["teller_id"], name: "index_stories_on_teller_id"
    t.index ["teller_title"], name: "index_stories_on_teller_title"
    t.index ["timeline_id"], name: "index_stories_on_timeline_id"
    t.index ["updated_at"], name: "index_stories_on_updated_at"
  end

  create_table "timelines", force: :cascade do |t|
    t.string "title"
    t.integer "protagonist_id"
    t.integer "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_timelines_on_author_id"
    t.index ["created_at"], name: "index_timelines_on_created_at"
    t.index ["protagonist_id"], name: "index_timelines_on_protagonist_id"
    t.index ["title"], name: "index_timelines_on_title"
    t.index ["updated_at"], name: "index_timelines_on_updated_at"
  end

  create_table "timelines_tellers", force: :cascade do |t|
    t.integer "timeline_id", null: false
    t.integer "teller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_timelines_tellers_on_created_at"
    t.index ["teller_id"], name: "index_timelines_tellers_on_teller_id"
    t.index ["timeline_id", "teller_id"], name: "index_timelines_tellers_on_timeline_id_and_teller_id", unique: true
    t.index ["timeline_id"], name: "index_timelines_tellers_on_timeline_id"
    t.index ["updated_at"], name: "index_timelines_tellers_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["lastname"], name: "index_users_on_lastname"
    t.index ["name"], name: "index_users_on_name"
    t.index ["password_digest"], name: "index_users_on_password_digest"
    t.index ["updated_at"], name: "index_users_on_updated_at"
  end

  create_table "users_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_users_roles_on_created_at"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["updated_at"], name: "index_users_roles_on_updated_at"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
