class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :movies, index:true
      t.belongs_to :users, index:true
      t.string :title
      t.datetime :review_date
      t.text :content

      t.timestamps
    end
  end
end
