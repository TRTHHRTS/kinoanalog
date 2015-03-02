class Star < ActiveRecord::Base
  has_many :star_records
  has_many :movies, through: :star_records
end
