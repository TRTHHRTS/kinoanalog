class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :movie, index:true
      t.belongs_to :user, index:true
      t.string :title
      t.datetime :review_date
      t.text :content
      t.boolean :isgood
      t.integer :mark
    end
  end
end
