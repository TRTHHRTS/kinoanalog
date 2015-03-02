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
Star.create([{name:'Джонни Депп'}])
Director.create([{name:'Кристофер Нолан'}])
Producer.create([{name:'Джерри Брукхаймер'}])
Writer.create([{name:'Люк Бессон'}])
Country.create([{name:'Россия'},
                {name:'США'},
                {name:'Германия'},
                {name:'Австралия'},
                {name:'Польша'},
                {name:'Франция'},
                {name:'Канада'},
                {name:'Венгрия'},
                {name:'Япония'},
                {name:'Китай'},
                {name:'Италия'},
                {name:'Латвия'},
                {name:'Литва'},
                {name:'Испания'},
                {name:'Великобритания'},
                {name:'Ирландия'}])