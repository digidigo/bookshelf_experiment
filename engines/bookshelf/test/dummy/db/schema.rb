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

ActiveRecord::Schema.define(version: 20140924102001) do

  create_table "bookshelf_ownerships", force: true do |t|
    t.integer  "people_user_id",  null: false
    t.integer  "library_book_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookshelf_ownerships", ["library_book_id"], name: "index_bookshelf_ownerships_on_library_book_id"
  add_index "bookshelf_ownerships", ["people_user_id", "library_book_id"], name: "udx_people_book", unique: true
  add_index "bookshelf_ownerships", ["people_user_id"], name: "index_bookshelf_ownerships_on_people_user_id"

end
