class CountryRecord < ActiveRecord::Base
  belongs_to :movie
  belongs_to :country
end
