# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#require 'sqlite3'

Genre.create([{name:'Аниме'},
              {name:'Биографический'},
              {name:'Боевик'},
              {name:'Вестерн'},
              {name:'Военный'},
              {name:'Детектив'},
              {name:'Детский'},
              {name:'Документальный'},
              {name:'Драма'},
              {name:'Исторический'},
              {name:'Кинокомикс'},
              {name:'Комедия'},
              {name:'Криминал'},
              {name:'Мелодрама'},
              {name:'Приключения'},
              {name:'Семейный'},
              {name:'Спорт'},
              {name:'Триллер'},
              {name:'Ужасы'},
              {name:'Фантастика'},
              {name:'Фильм-нуар'},
              {name:'Фэнтези'}])

# Open a SQLite 3 database file
#db = SQLite3::Database.new 'file.db'

# Create a table
#result = db.execute <<-SQL
#  CREATE TABLE numbers (
#    name VARCHAR(30),
#    val INT
#  );
#SQL

# Insert some data into it
#{ 'one' => 1, 'two' => 2 }.each do |pair|
#  db.execute 'insert into numbers values (?, ?)', pair
#end

# Find some records
#db.execute 'SELECT * FROM numbers' do |row|
#  p row
#end