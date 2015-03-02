class CreateWriterRecords < ActiveRecord::Migration
  def change
    create_table :writer_records do |t|
      t.references :movie
      t.references :writer
    end
  end
end
