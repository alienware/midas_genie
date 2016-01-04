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

ActiveRecord::Schema.define(version: 20151229200936) do

  create_table "midas_genie_options", force: :cascade do |t|
    t.text     "title",       null: false
    t.text     "description"
    t.text     "remark"
    t.integer  "question_id"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "midas_genie_options", ["deleted_at"], name: "index_midas_genie_options_on_deleted_at"
  add_index "midas_genie_options", ["question_id"], name: "index_midas_genie_options_on_question_id"
  add_index "midas_genie_options", ["title"], name: "index_midas_genie_options_on_title"

  create_table "midas_genie_questions", force: :cascade do |t|
    t.text     "title",       null: false
    t.text     "description"
    t.text     "remark"
    t.string   "type",        null: false
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "midas_genie_questions", ["deleted_at"], name: "index_midas_genie_questions_on_deleted_at"
  add_index "midas_genie_questions", ["title"], name: "index_midas_genie_questions_on_title"
  add_index "midas_genie_questions", ["type"], name: "index_midas_genie_questions_on_type"

  create_table "midas_genie_section_questions", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "question_id"
    t.datetime "deleted_at"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "midas_genie_section_questions", ["deleted_at"], name: "index_midas_genie_section_questions_on_deleted_at"
  add_index "midas_genie_section_questions", ["position"], name: "index_midas_genie_section_questions_on_position"
  add_index "midas_genie_section_questions", ["question_id"], name: "index_midas_genie_section_questions_on_question_id"
  add_index "midas_genie_section_questions", ["section_id"], name: "index_midas_genie_section_questions_on_section_id"

  create_table "midas_genie_sections", force: :cascade do |t|
    t.text     "title",                               null: false
    t.text     "description"
    t.text     "remark"
    t.datetime "deleted_at"
    t.integer  "section_questions_count", default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "midas_genie_sections", ["deleted_at"], name: "index_midas_genie_sections_on_deleted_at"
  add_index "midas_genie_sections", ["title"], name: "index_midas_genie_sections_on_title"

  create_table "midas_genie_survey_section_questions", force: :cascade do |t|
    t.integer  "survey_section_id"
    t.integer  "question_id"
    t.datetime "deleted_at"
    t.integer  "position"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "midas_genie_survey_section_questions", ["deleted_at"], name: "index_midas_genie_survey_section_questions_on_deleted_at"
  add_index "midas_genie_survey_section_questions", ["position"], name: "index_midas_genie_survey_section_questions_on_position"
  add_index "midas_genie_survey_section_questions", ["question_id"], name: "index_midas_genie_survey_section_questions_on_question_id"
  add_index "midas_genie_survey_section_questions", ["survey_section_id"], name: "index_midas_genie_survey_section_questions_survey_section_id"

  create_table "midas_genie_survey_sections", force: :cascade do |t|
    t.integer  "survey_id"
    t.integer  "section_id"
    t.datetime "deleted_at"
    t.integer  "position"
    t.integer  "survey_section_questions_count", default: 0, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "midas_genie_survey_sections", ["deleted_at"], name: "index_midas_genie_survey_sections_on_deleted_at"
  add_index "midas_genie_survey_sections", ["position"], name: "index_midas_genie_survey_sections_on_position"
  add_index "midas_genie_survey_sections", ["section_id"], name: "index_midas_genie_survey_sections_on_section_id"
  add_index "midas_genie_survey_sections", ["survey_id"], name: "index_midas_genie_survey_sections_on_survey_id"

  create_table "midas_genie_surveys", force: :cascade do |t|
    t.text     "title",       null: false
    t.text     "description"
    t.text     "remark"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "midas_genie_surveys", ["deleted_at"], name: "index_midas_genie_surveys_on_deleted_at"
  add_index "midas_genie_surveys", ["title"], name: "index_midas_genie_surveys_on_title"

end
