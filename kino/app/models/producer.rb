class Producer < ActiveRecord::Base
  has_many :producer_records
  has_many :movies, through: :producer_records
end
