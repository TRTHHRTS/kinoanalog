class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :movies, index:true
      t.belongs_to :user, index:true
      t.integer :rating

      t.timestamps
    end
  end
end
