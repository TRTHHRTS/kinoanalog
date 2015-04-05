# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#require 'sqlite3'

#Создание главного админа с id=1. Который впоследствие сможет наделять правами админа всех остальных юзеров.
admin = User.new(
    :login => 'admin',
    :password => '123456',
    :email => 'admin@mail.ru',
    :sex => 'Мужской',
    :permission => 1
)
admin.save!(:validate => false)
user = User.new(
    :login => 'user',
    :email => 'user@mail.ru',
    :password => '123456',
    :sex => 'Женский',
    :permission => 2
)
user.save!(:validate => false)
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
Star.create([{name:'Джонни Депп'},{name:'Эдвард Нортон'},{name:'Эдвард Ферлонг'},{name:'Беверли Д’Анджело'}])
Director.create([{name:'Кристофер Нолан'}, {name:'Тони Кэй'}])
Producer.create([{name:'Джерри Брукхаймер'}, {name:'Джон Мориссей'}, {name:'Билл Карраро'}, {name:'Майкл Де Лука'}])
Writer.create([{name:'Люк Бессон'}, {name:'Дэвид МакКенна'}])
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
Movie.create([{id:1, title:'Американская История Х', orig_title:'American history X', image_url:'/assets/images/movies/1.jpg',
               year:1998, release_date:'2015-04-01', duration:119, description:'Лидер местной банды скинхедов Дерек Виньярд прочно удерживает авторитет в своём районе. Убеждённый в своей правоте, он беспощадно расправляется с теми, кто имеет не белый цвет кожи. Независимость и смелость Дерека вызывают восхищение у его младшего брата Дэнни, который уже тоже сделал свой выбор.
Но зверское убийство двух чернокожих парней, совершённое Дереком, разделяет дороги братьев: Дерек оказывается в тюрьме, где существует свой расклад сил, а Дэнни на свободе успешно продолжает дело брата. До тех пор, пока их пути не пересеклись вновь…', rate_id:2}])
Movie.create([{id:2, title:'Мгла', orig_title:'The mist', year:2007, release_date:'2015-04-02',
               duration:119, description:'history..', rate_id:2}])
Movie.create([{id:3, title:'Третье пришествие', orig_title:'Третье пришествие', year:2005, release_date:'2015-04-15',
               duration:119, description:'history..', rate_id:2}])
Movie.create([{id:4, title:'Очередной слоупок', orig_title:'Slowpoke', year:2010, release_date:'2015-05-19',
               duration:119, description:'history..', rate_id:2}])
CountriesMovies.create([{movie_id:1, country_id:2}])
GenresMovies.create([{movie_id:1, genre_id:9},{movie_id:1, genre_id:13}])
DirectorsMovies.create([{director_id:2, movie_id:1}])
ProducersMovies.create([{producer_id:2, movie_id:1},{producer_id:3, movie_id:1},{producer_id:4, movie_id:1}])
StarsMovies.create([{star_id:2, movie_id:1},{star_id:3, movie_id:1},{star_id:4, movie_id:1}])
Review.create([{movie_id:1, user_id:1, title:'10/10', content:'
Что такое быть человеком, который подписал себе приговор своим мировоззрением и отношением к людям? И еще стать лидером для многих и в частности для своего брата?
И все это время следовать слепой ненависти, которая привела Дерека в тюрьму. И быть еще при этом идеалом для младшего брата, ради которого он держался три года и верил.

Каково быть скинхедом? Следовать идеологии и ненавидеть иных, отличающихся от него самого, людей? А потом понять, на сколько это все глупо и пусто, что это всего лишь маска, которую не просто так отвергнуть и сказать «нет» всему этому кошмару.

Или хотя бы уберечь своего младшего брата от этого.

Картина поднимает такие вопросы, что мысли не уйдут из головы надолго, но один из самых главных — «Как выжить в таком обществе, как его изменить или хотя бы самому безболезненно (подчеркнуто) измениться и уберечь всех близких от этого».

Как? Фильм актуален и вряд ли потеряет ее до тех пор, когда люди научаться жить мирно друг с другом.

10 из 10', recommended: true},
               {movie_id:1, user_id:2, title:'Средне', content:'В целом пойдет, но книга лучше', recommended: true},
               {movie_id:1, user_id:1, title:'Очень не очень =(', content:'Даже не тратьте свое время на это..', recommended: false}])
Rating.create([{id:1, movie_id:1, user_id:1, value:6},
               {id:2, movie_id:1, user_id:2, value:3}])
