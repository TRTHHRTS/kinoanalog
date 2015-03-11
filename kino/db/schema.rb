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

ActiveRecord::Schema.define(version: 20150228175657) do

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

  create_table "movies_producers", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "producer_id"
  end

  add_index "movies_producers", ["movie_id"], name: "index_movies_producers_on_movie_id"
  add_index "movies_producers", ["producer_id"], name: "index_movies_producers_on_producer_id"

  create_table "movies_stars", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "star_id"
  end

  add_index "movies_stars", ["movie_id"], name: "index_movies_stars_on_movie_id"
  add_index "movies_stars", ["star_id"], name: "index_movies_stars_on_star_id"

  create_table "movies_writers", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "writer_id"
  end

  add_index "movies_writers", ["movie_id"], name: "index_movies_writers_on_movie_id"
  add_index "movies_writers", ["writer_id"], name: "index_movies_writers_on_writer_id"

  create_table "producers", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "ratings", force: true do |t|
    t.integer "movie_id"
    t.integer "user_id"
    t.integer "rating"
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "reviews", force: true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "review_date"
    t.text     "content"
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "stars", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "password"
    t.integer "permission_type"
    t.string  "email"
  end

  create_table "writers", force: true do |t|
    t.string "name"
    t.string "url"
  end

end
