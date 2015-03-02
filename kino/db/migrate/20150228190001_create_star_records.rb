class CreateStarRecords < ActiveRecord::Migration
  def change
    create_table :star_records do |t|
      t.references :movie
      t.references :star
    end
  end
end

