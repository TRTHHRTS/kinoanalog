class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.text :name
      t.text :url
    end
  end
end