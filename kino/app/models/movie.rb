class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :ratings
  has_many :country_records
  has_many :countries, through: :country_records
  has_many :genre_records
  has_many :genres, through: :genre_records
  has_many :stars, through: :star_records
  has_many :producers, through: :producer_records
  has_many :directors, through: :director_records
  has_many :writers, through: :writer_records

end
