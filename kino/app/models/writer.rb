class Writer < ActiveRecord::Base
  has_many :writer_records
  has_many :movies, through: :writer_records
end
