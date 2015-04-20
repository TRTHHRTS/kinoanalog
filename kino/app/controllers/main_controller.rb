class MainController < ApplicationController
  before_action :set_movie, only: [:random]
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

  def details
    @movie = Movie.find(params[:id])
    @users = User.all
  end

  def random
    render 'main/details/'
  end

  #GET переход к расширенному поиску
  def extended_search
    @movies = Movie.all.limit(100)
  end

  #POST расширенный поиск
  def extended_search_result
    params[:title]=params[:title].strip
    params[:humanName]=params[:humanName].strip
    # TODO поиск по жанру: если id жанра='', т.е. пользователь выбрал все жанры, а пока что сделал через if

    if params[:genre][:genre_id]==''
      sql='SELECT m.id, m.title, m.release_date
           FROM movies m
           WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
          ', "%#{params[:title]}%", "%#{params[:title]}%", "%#{params[:date][:year]}%"

      if params[:humanName]!=''
          sql_tmp='SELECT d.id
                   FROM directors d
                   WHERE d.name LIKE ?', "%#{params[:humanName]}%"
          @dir_id=Director.find_by_sql(sql_tmp)

          sql_tmp='SELECT p.id
                   FROM producers p
                   WHERE p.name LIKE ?', "%#{params[:humanName]}%"
          @prod_id=Producer.find_by_sql(sql_tmp)

          sql_tmp='SELECT s.id
                   FROM stars s
                   WHERE s.name LIKE ?', "%#{params[:humanName]}%"
          @star_id=Star.find_by_sql(sql_tmp)

          sql='SELECT m.id, m.title, m.release_date
               FROM movies m
               WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
               AND
               (
                 m.id IN (
                 SELECT m.id
                 FROM movies m
                 LEFT JOIN directors_movies dm WHERE m.id = dm.movie_id AND dm.director_id = ?)

                 OR
                 m.id IN (
                 SELECT m.id
                 FROM movies m
                 LEFT JOIN producers_movies pm WHERE m.id = pm.movie_id AND pm.producer_id = ?)

                 OR
                 m.id IN (
                 SELECT m.id
                 FROM movies m
                 LEFT JOIN stars_movies sm WHERE m.id = sm.movie_id AND sm.star_id = ?)
               )
              ', "%#{params[:title]}%", "%#{params[:title]}%","%#{params[:date][:year]}%", @dir_id, @prod_id, @star_id
      end
    else
      sql='SELECT m.id, m.title, m.release_date
           FROM movies m
           WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
           AND
           m.id IN (
           SELECT m.id
           FROM movies m
           LEFT JOIN genres_movies gm WHERE m.id = gm.movie_id AND gm.genre_id = ?)
          ', "%#{params[:title]}%", "%#{params[:title]}%", "%#{params[:date][:year]}%", params[:genre][:genre_id]
      if params[:humanName]!=''
        sql_tmp='SELECT d.id
                 FROM directors d
                 WHERE d.name LIKE ?', "%#{params[:humanName]}%"
        @dir_id=Director.find_by_sql(sql_tmp)

        sql_tmp='SELECT p.id
                 FROM producers p
                 WHERE p.name LIKE ?', "%#{params[:humanName]}%"
        @prod_id=Producer.find_by_sql(sql_tmp)

        sql_tmp='SELECT s.id
                 FROM stars s
                 WHERE s.name LIKE ?', "%#{params[:humanName]}%"
        @star_id=Star.find_by_sql(sql_tmp)

        sql='SELECT m.id, m.title, m.release_date
             FROM movies m
             WHERE (m.title LIKE ? OR m.orig_title LIKE ?) AND m.release_date LIKE ?
             AND
             m.id IN (
             SELECT m.id
             FROM movies m
             LEFT JOIN genres_movies gm WHERE m.id = gm.movie_id AND gm.genre_id = ?)
             AND
             (
               m.id IN (
               SELECT m.id
               FROM movies m
               LEFT JOIN directors_movies dm WHERE m.id = dm.movie_id AND dm.director_id = ?)

               OR
               m.id IN (
               SELECT m.id
               FROM movies m
               LEFT JOIN producers_movies pm WHERE m.id = pm.movie_id AND pm.producer_id = ?)

               OR
               m.id IN (
               SELECT m.id
               FROM movies m
               LEFT JOIN stars_movies sm WHERE m.id = sm.movie_id AND sm.star_id = ?)
             )
            ', "%#{params[:title]}%", "%#{params[:title]}%","%#{params[:date][:year]}%", params[:genre][:genre_id], @dir_id, @prod_id, @star_id
      end
    end
    @movies=Movie.find_by_sql(sql)

    # это нужно для сохранения выбранной даты
    params[:year]=params[:date][:year].to_i

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
  def set_movie
    @movie = Movie.all[rand(0..Movie.count-1)]
    @users = User.all
  end

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

