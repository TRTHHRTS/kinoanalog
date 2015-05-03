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

    #поиск похожих фильмов
    sql2='SELECT m.id, m.title, m.image_url
             FROM movies m
             WHERE m.title LIKE ?', "%#{@movie.title}%"
    #@like_movies= Movie.find_by_sql(sql_tmp)
    mId = @movie.id
    dir_id = DirectorsMovies.where('movie_id = ?', mId).pluck('DISTINCT director_id')
    prod_id = ProducersMovies.where('movie_id = ?', mId).pluck('DISTINCT producer_id')
    star_id = StarsMovies.where('movie_id = ? ', mId).pluck('DISTINCT star_id')
    writer_id = WritersMovies.where('movie_id = ?', mId).pluck('DISTINCT writer_id')

    newSql = 'SELECT DISTINCT(m.id), m.title, m.image_url
              FROM movies m, directors_movies dm, producers_movies pm, stars_movies sm, writers_movies wm
              WHERE m.id <> ? AND m.id = dm.movie_id AND m.id = pm.movie_id AND m.id = sm.movie_id AND m.id = wm.movie_id AND
                (dm.director_id IN (?) OR pm.producer_id IN (?) OR sm.star_id IN (?) OR wm.writer_id IN (?))',
              mId, dir_id, prod_id, star_id, writer_id

    sql3='SELECT m.id, m.title, m.image_url
         FROM movies m
         WHERE (m.title LIKE ? OR m.orig_title LIKE ?)
         AND
         (
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN directors_movies dm WHERE m.id = dm.movie_id AND dm.director_id IN (?) )
         )
        ', "%#{@movie.title}%", "%#{@movie.orig_title}%", dir_id

    @like_movies=Movie.find_by_sql(newSql)
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

