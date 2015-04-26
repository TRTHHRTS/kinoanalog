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
    redirect_to '/details/' + mov_id.to_s
  end

  def details
    @movie = Movie.find(params[:id])
    @users = User.all

    #поиск похожих фильмов
    sql2='SELECT m.id, m.title, m.image_url
             FROM movies m
             WHERE m.title LIKE ?', "%#{@movie.title}%"
    #@like_movies= Movie.find_by_sql(sql_tmp)


    sql_tmp='SELECT dm.director_id AS id
             FROM directors_movies dm
             WHERE dm.movie_id = ?', @movie.id
    @dir_id=Director.find_by_sql(sql_tmp)

    sql_tmp='SELECT d.id
                   FROM directors d
                   WHERE d.id = ?', @dir_id
    #@dir_id=Director.find_by_sql(sql_tmp)

    sql_tmp='SELECT pm.producer_id AS id
             FROM producers_movies pm
             WHERE pm.movie_id = ?', @movie.id
    @prod_id=Producer.find_by_sql(sql_tmp)

    sql_tmp='SELECT sm.star_id AS id
             FROM stars_movies sm
             WHERE sm.movie_id = ?', @movie.id
    @star_id=Star.find_by_sql(sql_tmp)

    sql_tmp='SELECT wm.writer_id AS id
             FROM writers_movies wm
             WHERE wm.movie_id = ?', @movie.id
    @writer_id=Star.find_by_sql(sql_tmp)

    sql='SELECT m.id, m.title, m.image_url
         FROM movies m
         WHERE
         (
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN directors_movies dm WHERE m.id = dm.movie_id AND dm.director_id IN (?))

           OR
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN producers_movies pm WHERE m.id = pm.movie_id AND pm.producer_id IN (?))

           OR
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN stars_movies sm WHERE m.id = sm.movie_id AND sm.star_id IN (?))

           OR
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN writers_movies wm WHERE m.id = wm.movie_id AND wm.writer_id IN (?))
         )
        ', @dir_id, @prod_id, @star_id, @writer_id


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
        ', "%#{@movie.title}%", "%#{@movie.orig_title}%", @dir_id

    @like_movies=Movie.find_by_sql(sql)
  end

  #GET переход к расширенному поиску
  def extended_search
    @movies = Movie.all.limit(100)
  end

  #POST расширенный поиск
  def extended_search_result
    title=params[:title].strip

    genre_id = Genre.select('id')
    genre_id = params[:select][:genre] if params[:select][:genre] != ''

    sql='SELECT DISTINCT(m.id), m.title, m.release_date
              FROM movies m, genres_movies gm
              WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
                AND m.id = gm.movie_id AND gm.genre_id IN (?)
          ', "%#{title}%", "%#{title}%", "%#{params[:date][:year]}%", genre_id

      dir_id = Director.where('name LIKE ?', "%#{params[:dirName].strip}%")
      prod_id=Producer.where('name LIKE ?', "%#{params[:prodName].strip}%")
      star_id=Star.where('name LIKE ?', "%#{params[:starName].strip}%")
      writer_id=Writer.where('name LIKE ?', "%#{params[:writerName].strip}%")
      sql = 'SELECT DISTINCT(m.id), m.title, m.release_date
                    FROM movies m, directors_movies dm, producers_movies pm, stars_movies sm, writers_movies wm, genres_movies gm
                    WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
                      AND m.id = dm.movie_id AND m.id = pm.movie_id AND m.id = sm.movie_id AND m.id = wm.movie_id AND m.id = gm.movie_id
                      AND gm.genre_id IN (?)
                      AND (dm.director_id IN (?) OR pm.producer_id IN (?) OR sm.star_id IN (?) OR wm.writer_id IN (?) )
                  ', "%#{title}%", "%#{title}%","%#{params[:date][:year]}%", genre_id, dir_id, prod_id, star_id, writer_id

    @movies=Movie.find_by_sql(sql)
    puts @movies
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

