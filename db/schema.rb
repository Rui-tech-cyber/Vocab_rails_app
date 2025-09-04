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

ActiveRecord::Schema[7.2].define(version: 2025_09_04_091839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exam_answers", force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.bigint "word_id", null: false
    t.string "user_answer"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_answers_on_exam_id"
    t.index ["word_id"], name: "index_exam_answers_on_word_id"
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "word_book_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exams_on_user_id"
    t.index ["word_book_id"], name: "index_exams_on_word_book_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "word_books", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_word_books_on_user_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "term"
    t.string "meaning"
    t.bigint "word_book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_book_id"], name: "index_words_on_word_book_id"
  end

  add_foreign_key "exam_answers", "exams"
  add_foreign_key "exam_answers", "words"
  add_foreign_key "exams", "users"
  add_foreign_key "exams", "word_books"
  add_foreign_key "word_books", "users"
  add_foreign_key "words", "word_books"
end
