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
    @movies = Movie.all
  end

  def search
    @movies = Movie.all
  end
end
