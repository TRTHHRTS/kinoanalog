class MainController < ApplicationController
  before_action :set_movie, only: [:random]
  before_action :find_movies, only: [:search_result]
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
    #TODO и как найти все записи, удовлетворяющие условиям?
    #@movies = Movie.where('lower(title) LIKE lower(?)', "%#{params[:title]}%").find_all_by_release_date(params[:year])    and genre_id LIKE genre   , "%#{params[:genre]}%"
    @movies = Movie.where('(lower(title) LIKE lower(?) or orig_title LIKE ?)
                            and release_date LIKE ? ', "%#{params[:title]}%", "%#{params[:title]}%",
                          "%#{params[:year]}%") #and Movie.where('genre_id LIKE ?',"%#{params[:genre][:genre_id]}%")
    # TODO по жанру
    # на крайний случай как вариант через foreach выбрать фильмы, кот. соответ. жанру, что плохо!
    # @movies=@movies.genre.where('id LIKE ?', "%#{params[:genre][:genre_id]}%")
    render 'main/extended_search', notice: params
  end

  # GET обычный поиск
  def search_result
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

  def find_movies
    @movies = Movie.where('lower(title) LIKE lower(?)', "%#{params[:query]}%")
    @str_search = params[:query]
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

