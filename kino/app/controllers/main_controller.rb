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

  def random
=begin
    @movie.reviews.each { |review|
      @users = User.find(review.user_id)
    }
=end
  end

  def search
    @movies = Movie.all
  end

  # GET /main/search_result
  def search_result
  end

  private
    def set_movie
      @movie = Movie.includes(:countries, :genres, :directors, :producers, :writers, :stars).find(1)
      @users = User.all
    end

    def find_movies
      @movies = Movie.where("lower(title) LIKE lower(?)", "%#{params[:query]}%")
    end
end
