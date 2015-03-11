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
User.create([{id:1, name:'Admin', password:'1', permission_type:0, email:'kaluganin514@gmail.com'},
             {id:2, name:'trthhrts', password:'1', permission_type:1, email:'kaluganin514@mail.ru'}])
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
Movie.create([{id:1, title:'Американская История Х', orig_title:'American history X', year:1998, release_date:'1998-11-20',
               duration:119, description:'history..', rate_id:2}])
CountriesMovies.create([{id:1, movie_id:1, country_id:3},
                                {id:2, movie_id:1, country_id:6}])
GenresMovies.create([{movie_id:1, genre_id:4},
                             {movie_id:1, genre_id:5}])
Review.create([{id:1, movie_id:1, user_id:1, title:'Очень понравилсо!', content:'Такой захватывающий! От начала и до конца посмотрел!'},
               {id:2, movie_id:1, user_id:1, title:'Среднею', content:'В целом пойдет, но книга лучше'},
               {id:3, movie_id:1, user_id:1, title:'Очень не очень =(', content:'Даже не тратьте свое время на это..'}])
Rating.create([{id:1, movie_id:1, user_id:1, rating:6},
               {id:2, movie_id:1, user_id:2, rating:3}])
