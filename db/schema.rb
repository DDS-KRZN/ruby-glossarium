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

ActiveRecord::Schema[7.0].define(version: 2023_06_15_135409) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "glossary_id", null: false
    t.index ["glossary_id"], name: "index_categories_on_glossary_id"
  end

  create_table "category_words", force: :cascade do |t|
    t.integer "word_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_words_on_category_id"
    t.index ["word_id"], name: "index_category_words_on_word_id"
  end

  create_table "glossaries", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "archive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.text "definition"
    t.integer "glossary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glossary_id"], name: "index_words_on_glossary_id"
  end

  add_foreign_key "categories", "glossaries"
  add_foreign_key "category_words", "categories"
  add_foreign_key "category_words", "words"
  add_foreign_key "words", "glossaries"
end
