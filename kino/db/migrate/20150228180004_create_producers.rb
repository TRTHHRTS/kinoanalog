class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|
      t.text :name
      t.text :url
    end
  end
end