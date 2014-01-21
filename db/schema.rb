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

ActiveRecord::Schema.define(version: 20140121121823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "answers", force: true do |t|
    t.float    "value"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_challenge_id"
  end

  add_index "answers", ["user_challenge_id"], name: "index_answers_on_user_challenge_id", using: :btree

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "challenge_sets", force: true do |t|
    t.string   "name"
    t.boolean  "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_skills", force: true do |t|
    t.integer  "skill_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: true do |t|
    t.integer  "number_of_problems"
    t.string   "name"
    t.integer  "timelimit"
    t.integer  "bonus"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "steps"
    t.string   "type"
    t.integer  "challenge_set_id"
  end

  add_index "challenges", ["name"], name: "index_challenges_on_name", unique: true, using: :btree

  create_table "feedback_reports", force: true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.string   "subject"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id", "user_id"], name: "index_friendships_on_friend_id_and_user_id", unique: true, using: :btree

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "problems", force: true do |t|
    t.string   "formula"
    t.string   "question"
    t.text     "theory"
    t.float    "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_id"
    t.string   "type"
    t.float    "result"
  end

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unit_groups", ["name"], name: "index_unit_groups_on_name", unique: true, using: :btree

  create_table "units", force: true do |t|
    t.string   "name"
    t.string   "sign"
    t.integer  "unit_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["name"], name: "index_units_on_name", unique: true, using: :btree

  create_table "user_challenges", force: true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.boolean  "success"
    t.integer  "amount_fail",  default: 0
    t.integer  "amount_good",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.float    "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",                       null: false
    t.string   "encrypted_password",     default: "",                       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username",                                                  null: false
    t.string   "name"
    t.string   "profilepicture_url",     default: "/assets/no_profile.jpg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_group_id"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_group_id"], name: "index_users_on_user_group_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
