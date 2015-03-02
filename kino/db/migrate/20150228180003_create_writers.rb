class CreateWriters < ActiveRecord::Migration
  def change
    create_table :writers do |t|
      t.text :name
      t.text :url
    end
  end
end