class MoviesController < ApplicationController
  before_action :set_movie, only: [:edit_movie]
  before_action :movie_params, only: [:create_movie, :update_movie]
  before_action :check_only_admin_moder, only: [:new_movie, :create_movie, :edit_movie, :update_movie, :destroy_movie]
  # GET
  def new_movie
    @movie = Movie.new
  end

  # GET
  def edit_movie
  end

  # POST
  def create_movie

    redirect_to :back, notice: params

=begin
    @movie = Movie.new

    @movie.id = Movie.last.id + 1
    @movie.title = params[:movie][:title]
    @movie.orig_title = params[:movie][:orig_title]
    @movie.release_date = params[:movie][:release_date]
    @movie.duration = params[:movie][:duration]
    @movie.description = params[:movie][:description]
    @movie.age_id = params[:movie][:age_id]

    uploadedFile = params[:movie][:poster]
    if uploadedFile.nil?
      @movie.image_url = '/assets/images/movies/noposter.png'
    else
      extension = uploadedFile.original_filename.split('.').last
      directory = '/assets/images/movies'
      path = File.join(directory, @movie.id.to_s + '.' + extension)
      File.open('public'+path, 'wb') { |f| f.write(uploadedFile.read) }

      @movie.image_url = path
    end
=end

    #
    #respond_to do |format|
    #  if @movie.save
    #    format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Фильм успешно создан' }
    #    format.js {}
    #  else
    #    format.html { render action: 'new_movie' }
    #  end
    #end
  end

  # PATCH/PUT
  def update_movie
    @movie = Movie.find(params[:id])

    uploadedFile = params[:movie][:poster]
    unless uploadedFile.nil?
      unless @movie.image_url.split('/').include? 'noposter.png'
        File.delete('public' + @movie.image_url)
      end
      extension = uploadedFile.original_filename.split('.').last
      directory = '/assets/images/movies'
      path = File.join(directory, @movie.id.to_s + '.' + extension)
      File.open('public'+path, 'wb') { |f| f.write(uploadedFile.read) }
      params[:movie][:image_url] = path
    end
    params[:movie].delete(:poster)
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Информация о фильме успешно изменена' }
      else
        format.html { render action: 'edit_movie' }
      end
    end
  end

  # DELETE
  def destroy_movie
    @movie = Movie.find(params[:id])
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to main_path }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

  def movie_params
    params.permit(:id, :title, :orig_title, :release_date, :duration, :description, :age_id, :poster, :image_url, :countries,
      :directors, :movie_producers, :movie_stars, :movie_writers, :movie_countries)
  end

  def check_only_admin_moder
    if !user_signed_in? || current_user.permission > 2
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

end
