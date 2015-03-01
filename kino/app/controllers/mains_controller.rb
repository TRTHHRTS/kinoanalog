class MainsController < ApplicationController

  # GET /mains
  # GET /mains.json
  def index
  end

  # GET /mains/releases
  # GET /mains/releases.json
  def releases
    @movies = Movie.all
  end

  # GET /mains/releases
  # GET /mains/releases.json
  def random
    @movies = Movie.all
  end
end
