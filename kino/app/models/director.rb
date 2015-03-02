class Director < ActiveRecord::Base
  has_many :director_records
  has_many :movies, through: :director_records
end
