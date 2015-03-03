class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :movies, details:true
      t.belongs_to :user, details:true
      t.integer :rating
    end
  end
end
