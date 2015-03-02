class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.text :name
      t.text :url
    end
  end
end