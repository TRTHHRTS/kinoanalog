class Movie < ActiveRecord::Base
  belongs_to  :age
  has_many :reviews
  accepts_nested_attributes_for :reviews
  has_many :ratings
  has_and_belongs_to_many :countries, join_table: 'countries_movies'
  accepts_nested_attributes_for :countries
  has_and_belongs_to_many :genres, join_table: 'genres_movies'
  accepts_nested_attributes_for :genres
  has_and_belongs_to_many :stars, join_table: 'stars_movies'
  accepts_nested_attributes_for :stars
  has_and_belongs_to_many :producers, join_table: 'producers_movies'
  accepts_nested_attributes_for :producers
  has_and_belongs_to_many :directors, join_table: 'directors_movies'
  accepts_nested_attributes_for :directors
  has_and_belongs_to_many :writers, join_table: 'writers_movies'
  accepts_nested_attributes_for :writers
end
