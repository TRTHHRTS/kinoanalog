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
#User.create([{id:1, name:'Admin', password:'1', permission_type:0, email:'kaluganin514@gmail.com'},
#             {id:2, name:'trthhrts', password:'1', permission_type:1, email:'kaluganin514@mail.ru'}])
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
Movie.create([{id:1, title:'Американская История Х', orig_title:'American history X', image_url:'/assets/images/movies/1.jpg', year:1998, release_date:'2015-03-20',
               duration:119, description:'history..', rate_id:2}])
Movie.create([{id:2, title:'Мгла', orig_title:'The mist', year:2007, release_date:'2015-04-02',
               duration:119, description:'history..', rate_id:2}])
Movie.create([{id:3, title:'Третье пришествие', orig_title:'Третье пришествие', year:2005, release_date:'2015-04-15',
               duration:119, description:'history..', rate_id:2}])
Movie.create([{id:4, title:'Очередной слоупок', orig_title:'Slowpoke', year:2010, release_date:'2015-05-19',
               duration:119, description:'history..', rate_id:2}])
CountriesMovies.create([{id:1, movie_id:1, country_id:3},
                                {id:2, movie_id:1, country_id:6}])
GenresMovies.create([{movie_id:1, genre_id:4},
                             {movie_id:1, genre_id:5}])
Review.create([{id:1, movie_id:1, user_id:1, title:'Очень понравилсо!', content:'Такой захватывающий! От начала и до конца посмотрел!', isgood: true},
               {id:2, movie_id:1, user_id:1, title:'Средне', content:'В целом пойдет, но книга лучше', isgood: false},
               {id:3, movie_id:1, user_id:1, title:'Очень не очень =(', content:'Даже не тратьте свое время на это..', isgood: false}])
Rating.create([{id:1, movie_id:1, user_id:1, rating:6},
               {id:2, movie_id:1, user_id:2, rating:3}])
