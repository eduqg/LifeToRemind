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

ActiveRecord::Schema.define(version: 2019_06_03_231939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.boolean "checked"
    t.bigint "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_activities_on_goal_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "csfs", force: :cascade do |t|
    t.text "what_makes_me_unique"
    t.text "best_attributes"
    t.text "essential_atributes"
    t.text "health_factors"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_csfs_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.float "progress"
    t.bigint "objective_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["objective_id"], name: "index_goals_on_objective_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "purpose_of_life"
    t.text "who_am_i"
    t.string "why_exist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_missions_on_user_id"
  end

  create_table "objectives", force: :cascade do |t|
    t.string "name"
    t.boolean "concluded"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sphere_id"
    t.index ["plan_id"], name: "index_objectives_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.text "name"
    t.integer "selected_mission"
    t.integer "selected_vision"
    t.integer "selected_csf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_roles_on_plan_id"
  end

  create_table "spheres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.float "progress"
  end

  create_table "swotparts", force: :cascade do |t|
    t.bigint "plan_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "partname"
    t.index ["plan_id"], name: "index_swotparts_on_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "selected_plan"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "values", force: :cascade do |t|
    t.string "name"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_values_on_plan_id"
  end

  create_table "visions", force: :cascade do |t|
    t.text "where_im_going"
    t.text "where_arrive"
    t.text "how_complete_mission"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_visions_on_user_id"
  end

  add_foreign_key "activities", "goals"
  add_foreign_key "csfs", "users"
  add_foreign_key "goals", "objectives"
  add_foreign_key "objectives", "plans"
  add_foreign_key "plans", "users"
  add_foreign_key "roles", "plans"
  add_foreign_key "swotparts", "plans"
  add_foreign_key "values", "plans"
  add_foreign_key "visions", "users"
end
