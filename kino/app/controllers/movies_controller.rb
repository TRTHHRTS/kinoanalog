class MoviesController < ApplicationController
  before_action :set_movie, only: [:edit, :update, :destroy]

  # GET /movies/new
  def new_movie
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit_movie
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create_movie
    @movie = Movie.new(movie_params)
    @movie.id = Movie.last.id + 1

    respond_to do |format|
      if @movie.save
        format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Movie was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update_movie
    @movie = Movie.find(params[:id])
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Movie was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy_movie
    @movie = Movie.find(params[:id])
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to main_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

  def movie_params
    params.require(:movie).permit(:id, :title, :orig_title, :year, :release_date, :duration, :description, :age_id, :poster)
  end
end
