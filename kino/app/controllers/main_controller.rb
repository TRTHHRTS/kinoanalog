class MainController < ApplicationController
  before_action :set_movie, only: [:random]
  before_action :find_movies, only: [:search_result]

  # GET /main
  # GET /main.json
  def index
    @user = User.create
  end

  # GET /main/releases
  # GET /main/releases.json
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
    render 'main/details'
  end

  def search
    @movies = Movie.all
  end

  # GET /main/search_result
  def search_result
  end

  private
    def set_movie
      @movie = Movie.find(rand(Movie.count - 1) + 1)
      @users = User.all
    end

    def find_movies
      @movies = Movie.where("lower(title) LIKE lower(?)", "%#{params[:query]}%")
    end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit(:id, :title, :orig_title, :year, :release_date, :duration, :description, :rate_id)
  end

  def param_id
    params.require(:movie).permit(:id)
  end
end
