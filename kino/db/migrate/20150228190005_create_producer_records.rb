class CreateProducerRecords < ActiveRecord::Migration
  def change
    create_table :producer_records do |t|
      t.references :producer
      t.references :movie
    end
  end
end
