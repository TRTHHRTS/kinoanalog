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

ActiveRecord::Schema.define(version: 20150420171844) do

  create_table "ages", force: true do |t|
    t.string "name"
    t.string "image_url"
  end

  create_table "countries", force: true do |t|
    t.string "name"
  end

  create_table "countries_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "country_id"
  end

  add_index "countries_movies", ["country_id"], name: "index_countries_movies_on_country_id"
  add_index "countries_movies", ["movie_id"], name: "index_countries_movies_on_movie_id"

  create_table "directors", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "directors_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "director_id"
  end

  add_index "directors_movies", ["director_id"], name: "index_directors_movies_on_director_id"
  add_index "directors_movies", ["movie_id"], name: "index_directors_movies_on_movie_id"

  create_table "genres", force: true do |t|
    t.string "name"
  end

  create_table "genres_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "genre_id"
  end

  add_index "genres_movies", ["genre_id"], name: "index_genres_movies_on_genre_id"
  add_index "genres_movies", ["movie_id"], name: "index_genres_movies_on_movie_id"

  create_table "movies", force: true do |t|
    t.string  "title"
    t.string  "orig_title"
    t.date    "release_date"
    t.integer "duration"
    t.text    "description"
    t.integer "age_id"
    t.string  "image_url"
  end

  create_table "producers", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "producers_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "producer_id"
  end

  add_index "producers_movies", ["movie_id"], name: "index_producers_movies_on_movie_id"
  add_index "producers_movies", ["producer_id"], name: "index_producers_movies_on_producer_id"

  create_table "ratings", force: true do |t|
    t.integer "movie_id"
    t.integer "user_id"
    t.integer "value"
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "reviews", force: true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "review_date"
    t.text     "content"
    t.boolean  "recommended"
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "stars", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "stars_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "star_id"
  end

  add_index "stars_movies", ["movie_id"], name: "index_stars_movies_on_movie_id"
  add_index "stars_movies", ["star_id"], name: "index_stars_movies_on_star_id"

  create_table "users", force: true do |t|
    t.string  "encrypted_password",                        null: false
    t.string  "email",                                     null: false
    t.string  "name",                                      null: false
    t.string  "sex",                default: "Неизвестно", null: false
    t.integer "permission",         default: 3,            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "writers", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "writers_movies", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "writer_id"
  end

  add_index "writers_movies", ["movie_id"], name: "index_writers_movies_on_movie_id"
  add_index "writers_movies", ["writer_id"], name: "index_writers_movies_on_writer_id"

end
