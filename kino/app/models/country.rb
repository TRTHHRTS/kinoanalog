class Country < ActiveRecord::Base
  has_many :country_records
  has_many :movies, through: :country_records
end
