class MainController < ApplicationController

  # GET /main
  # GET /main.json
  def index
  end

  # GET /main/releases
  # GET /main/releases.json
  def releases
    @movies = Movie.all
  end

  # GET /main/releases
  # GET /main/releases.json
  def random
    @movie = Movie.find(1)
  end

  def search
    @movies = Movie.all
  end
end
