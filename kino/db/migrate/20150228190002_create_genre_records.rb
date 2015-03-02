class CreateGenreRecords < ActiveRecord::Migration
  def change
    create_table :genre_records do |t|
      t.references :movie
      t.references :genre
    end
  end
end

