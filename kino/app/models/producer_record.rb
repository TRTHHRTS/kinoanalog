class ProducerRecord < ActiveRecord::Base
  belongs_to :producer
  belongs_to :movie
end
