class MainController < ApplicationController
  before_action :check_only_admin_moder, only: [:users, :destroy_profile]
  before_action :check_only_admin, only: [:change_rights]

  # GET /main
  def index
    @user = User.create
  end

  # GET /main/releases
  def releases
    date = Date.today - Date.today.day + 1.day
    @movies = Movie.where('release_date >= ? AND release_date < ?', date, date + 3.month).order(:release_date)
  end

  def new
    @movie = Movie.new
  end

  # GET случайный фильм
  def random
    mov_id = 0
    until Movie.exists?(mov_id)
      mov_id = rand(0..Movie.count-1)
    end
    redirect_to '/details/' + mov_id.to_s, flash: { action: 'random' }
  end

  def details
    @movie = Movie.find(params[:id])
    @users = User.all

    sTitle = Array.new
    @movie.title.split.each do |str|
      sTitle << str.gsub(/[:,0-9]/, '')
    end
    sOrigTitle = Array.new
    @movie.orig_title.split.each do |str|
      sOrigTitle << str.gsub(/[:,0-9]/, '')
    end

    allMovies = Movie.all
    # хэш, в котором ключ - идентификатор фильма, а значение - сумма "очков". Чем больше значение - тем больше фильм похож на исходный
    movies = Hash.new
    allMovies.each do |mov|
      next if mov.id == @movie.id
      counter = 0

      # плюсуем за совпадения слов в названии фильма
      sTitle.each do |str|
        counter += 10 if mov.title.include? str
      end
      # плюсуем за совпадения слов в оригинальном названии фильма
      sOrigTitle.each do |str|
        counter += 10 if mov.orig_title.include? str
      end
      # плюсуем за похожих режиссеров
      sql = 'SELECT COUNT(1)
                FROM directors_movies dm
                WHERE dm.movie_id = ? AND dm.director_id IN (?) AND dm.director_id IN (?)', mov.id, mov.directors.pluck('id'), @movie.directors.pluck('id')
      counter += DirectorsMovies.count_by_sql(sql)*10
      # плюсуем за похожих продюсеров
      sql = 'SELECT COUNT(1)
                FROM producers_movies pm
                WHERE pm.movie_id = ? AND pm.producer_id IN (?) AND pm.producer_id IN (?)', mov.id, mov.producers.pluck('id'), @movie.producers.pluck('id')
      counter += ProducersMovies.count_by_sql(sql)*5
      # плюсуем за похожих актеров
      sql = 'SELECT COUNT(1)
                FROM stars_movies sm
                WHERE sm.movie_id = ? AND sm.star_id IN (?) AND sm.star_id IN (?)', mov.id, mov.stars.pluck('id'), @movie.stars.pluck('id')
      counter += StarsMovies.count_by_sql(sql)*5
      # плюсуем за похожих сценаристов
      sql = 'SELECT COUNT(1)
                FROM writers_movies wm
                WHERE wm.movie_id = ? AND wm.writer_id IN (?) AND wm.writer_id IN (?)', mov.id, mov.writers.pluck('id'), @movie.writers.pluck('id')
      counter += WritersMovies.count_by_sql(sql)*8
      # плюсуем за одинаковый год выпуска
      counter += 4 if @movie.release_date.year == mov.release_date.year
      # плюсуем за одинаковое возрастное ограничение
      counter += 2 if @movie.age_id == mov.age_id
      # плюсуем за одинаковые страны
      sql = 'SELECT COUNT(1)
                FROM countries_movies cm
                WHERE cm.movie_id = ? AND cm.country_id IN (?) AND cm.country_id IN (?)', mov.id, mov.countries.pluck('id'), @movie.countries.pluck('id')
      counter += CountriesMovies.count_by_sql(sql)
      # плюсуем за одинаковые жанры
      sql = 'SELECT COUNT(1)
                FROM genres_movies gm
                WHERE gm.movie_id = ? AND gm.genre_id IN (?) AND gm.genre_id IN (?)', mov.id, mov.genres.pluck('id'), @movie.genres.pluck('id')
      counter += GenresMovies.count_by_sql(sql)*3

      if counter > 0
        movies[mov.id]=counter
      end
    end
    movies = movies.sort_by(&:last).reverse.to_h

    @like_movies = Array.new
    movies.each do |k,v|
      @like_movies << Movie.find(k)
    end
    @counts = movies.values

  end

  #GET переход к расширенному поиску
  def extended_search
    @movies = Movie.all.limit(100)
    @min_year = Movie.pluck('MIN(release_date)').first.to_date.year.to_i
    @max_year = Movie.pluck('MAX(release_date)').first.to_date.year.to_i
end

  #POST расширенный поиск
  def extended_search_result
    title=params[:title].strip
    genre_id = params[:select][:genre] == '' ? Genre.select('id') : params[:select][:genre]
    country_id = params[:select][:country] == '' ? Country.select('id') : params[:select][:country]
    age_id =  params[:select][:age] == '' ? Age.select('id') : params[:select][:age]

      dir_id = Director.where('name LIKE ?', "%#{params[:dirName].strip}%")
      prod_id=Producer.where('name LIKE ?', "%#{params[:prodName].strip}%")
      star_id=Star.where('name LIKE ?', "%#{params[:starName].strip}%")
      writer_id=Writer.where('name LIKE ?', "%#{params[:writerName].strip}%")
      sql = 'SELECT DISTINCT(m.id), m.title, m.orig_title, m.release_date
                    FROM movies m, directors_movies dm, producers_movies pm, stars_movies sm, writers_movies wm, genres_movies gm, countries_movies cm
                    WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ? AND m.age_id IN (?)
                      AND m.id = dm.movie_id AND m.id = pm.movie_id AND m.id = sm.movie_id AND m.id = wm.movie_id AND m.id = gm.movie_id
                      AND gm.genre_id IN (?) AND cm.country_id IN (?)
                      AND (dm.director_id IN (?) OR pm.producer_id IN (?) OR sm.star_id IN (?) OR wm.writer_id IN (?) )
                  ', "%#{title}%", "%#{title}%","%#{params[:date][:year]}%", age_id,  genre_id, country_id, dir_id, prod_id, star_id, writer_id

    @movies=Movie.find_by_sql(sql)
    render 'main/extended_search', notice: params
  end

  # GET обычный поиск
  def search_result
    arg = params[:title]
    @movies = Movie.where('lower(title) LIKE lower(?) OR lower(orig_title) LIKE lower(?)', "%#{arg}%", "%#{arg}%")

    render 'main/extended_search'
  end

  def profile
    @user = User.find(params[:id])
  end

  # DELETE
  def destroy_profile
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :main }
    end
  end

  def users
    @users = User.all
  end

  def findItem
    @mov = Movie.where('title LIKE ?', "%#{params[:name]}%")
    if @mov.count == 0
      render :json => { success: false }
    else
      render :json => { success: true, object: @mov}
    end
  end

  def change_rights
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(permission: params[:change_to])
        format.html { redirect_to :back, notice: 'Права пользователя изменен' }
      else
        format.html { redirect_to :back, notice: 'Ошибка, не удалось изменить права пользователя' }
      end
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:id, :title, :orig_title, :year, :release_date, :duration, :description, :rate_id)
  end

  def check_only_admin_moder
    if !user_signed_in? || current_user.permission > 2
      render_404
    end
  end

  def check_only_admin
    if !user_signed_in? || current_user.permission != 1
      render_404
    end
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def param_id
    params.require(:movie).permit(:id)
  end
end

