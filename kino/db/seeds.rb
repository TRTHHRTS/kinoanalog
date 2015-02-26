# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'sqlite3'

# Open a SQLite 3 database file
db = SQLite3::Database.new 'file.db'

# Create a table
result = db.execute <<-SQL
  CREATE TABLE numbers (
    name VARCHAR(30),
    val INT
  );
SQL

# Insert some data into it
{ 'one' => 1, 'two' => 2 }.each do |pair|
  db.execute 'insert into numbers values (?, ?)', pair
end

# Find some records
db.execute 'SELECT * FROM numbers' do |row|
  p row
end