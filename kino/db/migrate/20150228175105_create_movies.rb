class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :orig_title
      t.integer :year
      t.date :release_date
      t.integer :duration
      t.text :description
      t.integer :rate_id

      t.timestamps
    end
  end
end
