class CreateDirectorRecords < ActiveRecord::Migration
  def change
    create_table :director_records do |t|
      t.references :movie
      t.references :director
    end
  end
end
