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
    :name => 'admin',
    :password => '123456',
    :email => 'admin@mail.ru',
    :sex => 'Мужской',
    :permission => 1
)
admin.save!(:validate => false)
user = User.new(
    :name => 'user',
    :email => 'user@mail.ru',
    :password => '123456',
    :sex => 'Женский',
    :permission => 3
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
Star.create([{name:'Джонни Депп'},{name:'Эдвард Нортон'},{name:'Эдвард Ферлонг'},{name:'Беверли Д’Анджело'},
             {name:'Роберт Дауни мл.'},{name:'Крис Хемсворт'},{name:'Крис Эванс'},{name:'Скарлетт Йоханссон'},{name:'Марк Руффало'},{name:'Джереми Реннер'}])
Director.create([{name:'Кристофер Нолан'}, {name:'Тони Кэй'}, {name:'Джосс Уидон'}])
Producer.create([{name:'Джерри Брукхаймер'}, {name:'Джон Мориссей'}, {name:'Билл Карраро'}, {name:'Майкл Де Лука'},
                 {name:'Кевин Файги'},{name:'Виктория Алонсо'},{name:'Митчелл Белл'}])
Writer.create([{name:'Люк Бессон'}, {name:'Дэвид МакКенна'}, {name:'Джосс Уидон'}, {name:'Стэн Ли'}, {name:'Джек Кирби'}])
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
Age.create([{name:'0+'},
            {name:'6+'},
            {name:'12+'},
            {name:'16+'},
            {name:'18+'}])
Movie.create([{id:1, title:'Американская История Х', orig_title:'American history X', image_url:'/assets/images/movies/1.jpg',
               release_date:'2015-04-01', duration:119, description:"Лидер местной банды скинхедов Дерек Виньярд прочно удерживает авторитет в своём районе. Убеждённый в своей правоте, он беспощадно расправляется с теми, кто имеет не белый цвет кожи. Независимость и смелость Дерека вызывают восхищение у его младшего брата Дэнни, который уже тоже сделал свой выбор.\n
Но зверское убийство двух чернокожих парней, совершённое Дереком, разделяет дороги братьев: Дерек оказывается в тюрьме, где существует свой расклад сил, а Дэнни на свободе успешно продолжает дело брата. До тех пор, пока их пути не пересеклись вновь…", age_id:4}])
Movie.create([{id:2, title:'Мгла', orig_title:'The mist', release_date:'2015-04-02',
               duration:119, description:'history..', age_id:2, image_url:'/assets/images/movies/noposter.png'}])
Movie.create([{id:3, title:'Третье пришествие', orig_title:'Третье пришествие', release_date:'2015-04-15',
               duration:119, description:'history..', age_id:3, image_url:'/assets/images/movies/noposter.png'}])
Movie.create([{id:4, title:'Очередной слоупок', orig_title:'Slowpoke', release_date:'2015-05-19',
               duration:119, description:'history..', age_id:4, image_url:'/assets/images/movies/noposter.png'}])
Movie.create([{id:5, title:'Мстители: Эра Альтрона', orig_title:'Avengers: Age of Ultron', release_date:'2015-04-23',
               duration:141, description:"Человечество на грани уничтожения. На этот раз людям угрожает Альтрон — искусственный интеллект, ранее созданный для того, чтобы защищать Землю от любых угроз.\n
Однако, главной угрозой он посчитал человечество. Международная организация Щ. И. Т распалась, и теперь мир не способен справиться с таким мощным врагом, потому люди вновь обращаются за помощью к Величайшим Героям Земли — Мстителям.\n
Однако Альтрон слишком силен, и есть большая вероятность, что даже им не удастся остановить начало надвигающейся Эры Альтрона, где нет места для людей…", age_id:3, image_url:'/assets/images/movies/5.jpg'}])
Movie.create([{id:6, title:'Мстители', orig_title:'The Avengers', release_date:'2012-03-21',
               duration:141, description:"Локи, сводный брат Тора, возвращается, и в этот раз он не один. Земля на грани порабощения, и только лучшие из лучших могут спасти человечество.\n
Ник Фьюри, глава международной организации Щ. И. Т., собирает выдающихся поборников справедливости и добра, чтобы отразить атаку. Под предводительством Капитана Америки Железный Человек, Тор, Невероятный Халк, Соколиный глаз и Чёрная Вдова вступают в войну с захватчиком.",
               age_id:3, image_url:'/assets/images/movies/6.jpg'}])
CountriesMovies.create([{movie_id:1, country_id:2}, {movie_id:5, country_id:2}])
GenresMovies.create([{movie_id:1, genre_id:9},{movie_id:1, genre_id:13},
                     {movie_id:2, genre_id:20}, {movie_id:2, genre_id:3}, {movie_id:2, genre_id:18},
                     {movie_id:2, genre_id:15},{movie_id:6, genre_id:20}])
DirectorsMovies.create([{director_id:2, movie_id:1}, {director_id:3, movie_id:5}, {director_id:3, movie_id:6}])
ProducersMovies.create([{producer_id:2, movie_id:1},{producer_id:3, movie_id:1},{producer_id:4, movie_id:1},
                        {producer_id:5, movie_id:5},{producer_id:6, movie_id:5},{producer_id:7, movie_id:1},
                        {producer_id:5, movie_id:6},{producer_id:6, movie_id:6},{producer_id:7, movie_id:6}])
WritersMovies.create([{writer_id:3, movie_id: 5}, {writer_id:4, movie_id: 5}, {writer_id:5, movie_id: 5}, {writer_id:3, movie_id: 6}])
StarsMovies.create([{star_id:2, movie_id:1},{star_id:3, movie_id:1},{star_id:4, movie_id:1},{star_id:10, movie_id:5},
                    {star_id:5, movie_id:5},{star_id:6, movie_id:5},{star_id:7, movie_id:5},{star_id:8, movie_id:5},{star_id:9, movie_id:5},
                    {star_id:5, movie_id:6},{star_id:6, movie_id:6},{star_id:7, movie_id:6},{star_id:8, movie_id:6},{star_id:9, movie_id:6}])
Review.create([{movie_id:1, user_id:1, title:'10/10', content:"
Что такое быть человеком, который подписал себе приговор своим мировоззрением и отношением к людям? И еще стать лидером для многих и в частности для своего брата?\n
И все это время следовать слепой ненависти, которая привела Дерека в тюрьму. И быть еще при этом идеалом для младшего брата, ради которого он держался три года и верил.\n
Каково быть скинхедом? Следовать идеологии и ненавидеть иных, отличающихся от него самого, людей? А потом понять, на сколько это все глупо и пусто, что это всего лишь маска, которую не просто так отвергнуть и сказать «нет» всему этому кошмару.\n
Или хотя бы уберечь своего младшего брата от этого.\n
Картина поднимает такие вопросы, что мысли не уйдут из головы надолго, но один из самых главных — «Как выжить в таком обществе, как его изменить или хотя бы самому безболезненно (подчеркнуто) измениться и уберечь всех близких от этого».\n
Как? Фильм актуален и вряд ли потеряет ее до тех пор, когда люди научаться жить мирно друг с другом.\n
10 из 10", recommended: true},
               {movie_id:1, user_id:2, title:'Средне', content:'В целом пойдет, но книга лучше', recommended: true},
               {movie_id:1, user_id:1, title:'Очень не очень =(', content:'Даже не тратьте свое время на это..', recommended: false}])
Rating.create([{id:1, movie_id:1, user_id:1, value:5},
               {id:2, movie_id:1, user_id:2, value:3}])
