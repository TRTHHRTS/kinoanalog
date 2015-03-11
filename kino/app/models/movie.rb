class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :ratings
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :stars
  has_and_belongs_to_many :producers
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :writers
end
