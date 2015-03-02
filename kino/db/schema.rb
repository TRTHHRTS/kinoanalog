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

ActiveRecord::Schema.define(version: 20150228190005) do

  create_table "countries", force: true do |t|
    t.text "name"
  end

  create_table "country_records", force: true do |t|
    t.integer "movie_id"
    t.integer "country_id"
  end

  create_table "director_records", force: true do |t|
    t.integer "movie_id"
    t.integer "director_id"
  end

  create_table "directors", force: true do |t|
    t.text "name"
    t.text "url"
  end

  create_table "genre_records", force: true do |t|
    t.integer "movie_id"
    t.integer "genre_id"
  end

  create_table "genres", force: true do |t|
    t.text "name"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "orig_title"
    t.integer  "year"
    t.date     "release_date"
    t.integer  "duration"
    t.text     "description"
    t.integer  "rate_id"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "producer_records", force: true do |t|
    t.integer "producer_id"
    t.integer "movie_id"
  end

  create_table "producers", force: true do |t|
    t.text "name"
    t.text "url"
  end

  create_table "ratings", force: true do |t|
    t.integer "movies_id"
    t.integer "user_id"
    t.integer "rating"
  end

  add_index "ratings", ["movies_id"], name: "index_ratings_on_movies_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "reviews", force: true do |t|
    t.integer  "movies_id"
    t.integer  "users_id"
    t.string   "title"
    t.datetime "review_date"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["movies_id"], name: "index_reviews_on_movies_id"
  add_index "reviews", ["users_id"], name: "index_reviews_on_users_id"

  create_table "star_records", force: true do |t|
    t.integer "movie_id"
    t.integer "star_id"
  end

  create_table "stars", force: true do |t|
    t.text "name"
    t.text "url"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "permission_type"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "writer_records", force: true do |t|
    t.integer "movie_id"
    t.integer "writer_id"
  end

  create_table "writers", force: true do |t|
    t.text "name"
    t.text "url"
  end

end
