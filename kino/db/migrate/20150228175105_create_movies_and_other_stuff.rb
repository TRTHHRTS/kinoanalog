class CreateMoviesAndOtherStuff < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :orig_title
      t.date :release_date
      t.integer :duration
      t.text :description
      t.integer :age_id
      t.string :image_url
    end

    create_table :genres do |t|
      t.string :name
    end
    create_table :ages do |t|
      t.string :name
      t.string :image_url
    end
    create_table :countries do |t|
      t.string :name
    end
    create_table :directors do |t|
      t.string :name
      t.string :url
    end
    create_table :producers do |t|
      t.string :name
      t.string :url
    end
    create_table :writers do |t|
      t.string :name
      t.string :url
    end
    create_table :stars do |t|
      t.string :name
      t.string :url
    end

    create_table :genres_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :genre, index: true
    end
    create_table :countries_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :country, index: true
    end
    create_table :directors_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :director, index: true
    end
    create_table :producers_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :producer, index: true
    end
    create_table :writers_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :writer, index: true
    end
    create_table :stars_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :star, index: true
    end
  end
end
