class CreateCountryRecords < ActiveRecord::Migration
  def change
    create_table :country_records do |t|
      t.references :movie
      t.references :country

      t.timestamps
    end
  end
end
