class CreateGenreRecords < ActiveRecord::Migration
  def change
    create_table :genre_records do |t|
      t.references :movie
      t.references :genre

      t.timestamps
    end
  end
end
