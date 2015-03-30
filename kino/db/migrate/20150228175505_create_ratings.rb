class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :movie, index:true
      t.belongs_to :user, index:true
      t.integer :value
    end
  end
end
