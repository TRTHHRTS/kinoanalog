class Genre < ActiveRecord::Base
  has_many :genre_records
  has_many :movies, through: :genre_records
end
