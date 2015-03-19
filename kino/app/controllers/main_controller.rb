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


  def details
=begin
    @movie.reviews.each { |review|
      @users = User.find(review.user_id)
    }
=end
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
end
