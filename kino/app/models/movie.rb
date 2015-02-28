class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :ratings
  has_many :country_records
  has_many :countries, through: :country_records
  has_many :genre_records
  has_many :genres, through: :genre_records
end
