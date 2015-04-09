class MainController < ApplicationController
  before_action :set_movie, only: [:random]
  before_action :find_movies, only: [:search_result]
  before_action :check_rights, only: [:users]

  # GET /main
  def index
    @user = User.create
  end

  # GET /main/releases
  def releases
    @movies = Movie.all
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

  def search
    @movies = Movie.all
  end

  # GET /main/search_result
  def search_result
  end

  def profile
    @user = User.find(params[:id])
  end

  # DELETE /main/1
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
    @movies = Movie.where("lower(title) LIKE lower(?)", "%#{params[:query]}%")
    @str_search = params[:query]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit(:id, :title, :orig_title, :year, :release_date, :duration, :description, :rate_id)
  end

  def check_rights
    if current_user.permission > 1
      redirect_to main_path, notice: 'Отсутствуют права'
    end
  end

  def param_id
    params.require(:movie).permit(:id)
  end
end
