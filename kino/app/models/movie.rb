class Movie < ActiveRecord::Base
  belongs_to  :age
  has_many :reviews
  has_many :ratings
  has_and_belongs_to_many :countries, join_table: 'countries_movies'
  has_and_belongs_to_many :genres, join_table: 'genres_movies'
  has_and_belongs_to_many :stars, join_table: 'stars_movies'
  has_and_belongs_to_many :producers, join_table: 'producers_movies'
  has_and_belongs_to_many :directors, join_table: 'directors_movies'
  has_and_belongs_to_many :writers, join_table: 'writers_movies'
end
