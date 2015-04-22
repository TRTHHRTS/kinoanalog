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
    @movie = Movie.new
    @movie.id = Movie.last.id + 1
    @movie.title = params[:title]
    @movie.orig_title = params[:orig_title]
    @movie.release_date = params[:release_date]
    @movie.duration = params[:duration]
    @movie.description = params[:description]
    @movie.age_id = params[:age_id]
    # Добавление стран к сущности фильма
    unless params[:countries].nil?
      params[:countries].each { |c|
        @movie.countries << Country.find_by_name(c)
      }
    end
    # Добавление жанров к сущности фильма
    unless params[:genres].nil?
      params[:genres].each { |g|
        @movie.genres << Genre.find_by_name(g)
      }
    end
    # Добавление актеров к сущности фильма и их сохранение
    unless params[:stars].nil?
      params[:stars].each { |k,v|
        star = Star.find_by_name(k)
        if star.nil?
          star = Star.new(id:Star.last.id + 1, name: k, url: v)
          star.save
        else
          if star.url.nil?
            star.url=v
            star.save
          end
        end
        @movie.stars << star
      }
    end
    # Добавление режиссеров к сущности фильма и их сохранение
    unless params[:directors].nil?
      params[:directors].each { |k,v|
        director = Director.find_by_name(k)
        if director.nil?
          director = Director.new(id:Director.last.id + 1, name: k, url: v)
          director.save
        else
          if director.url.nil?
            director.url=v
            director.save
          end
        end
        @movie.directors << director
      }
    end
    # Добавление продюсеров к сущности фильма и их сохранение
    unless params[:producers].nil?
      params[:producers].each { |k,v|
        producer = Producer.find_by_name(k)
        if producer.nil?
          producer = Producer.new(id:Producer.last.id + 1, name: k, url: v)
          producer.save
        else
          if producer.url.nil?
            producer.url=v
            producer.save
          end
        end
        @movie.producers << producer
      }
    end
    # Добавление сценаристов к сущности фильма и их сохранение
    unless params[:writers].nil?
      params[:writers].each { |k,v|
        writer = Writer.find_by_name(k)
        if writer.nil?
          writer = Writer.new(id:Writer.last.id + 1, name: k, url: v)
          writer.save
        else
          if writer.url.nil?
            writer.url=v
            writer.save
          end
        end
        @movie.writers << writer
      }
    end
    # Сохранение постера
    poster = params[:file][:poster] unless params[:file].nil?
    if poster.nil?
      @movie.image_url = '/assets/images/movies/noposter.png'
    else
      extension = poster.original_filename.split('.').last
      directory = '/assets/images/movies'
      path = File.join(directory, @movie.id.to_s + '.' + extension)
      File.open('public'+path, 'wb') { |f| f.write(poster.read) }

      @movie.image_url = path
    end

    respond_to do |format|
      if @movie.save
        format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Фильм успешно создан' }
        format.js {}
      else
        format.html { render action: 'new_movie' }
      end
    end
  end


  # PATCH/PUT
  def update_movie
    #TODO Переделать по аналогии с добавлением фильма.
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
      format.html { redirect_to releases_path }
    end
  end

  def add_rating
    rated = Rating.find_by(user_id: params[:user_id], movie_id: params[:movie_id])
    unless rated
      Rating.create(user_id: params[:user_id], movie_id: params[:movie_id], value: params[:rating_value])
      redirect_to :back, notice: 'Спасибо, мы учли твой голос!'
      return
    end
    redirect_to :back, notice: 'Что-то пошло не так..'
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

  def movie_params
    params.permit(:id, :title, :orig_title, :release_date, :duration, :description, :age_id, :poster, :countries,
      :directors, :producers, :stars, :writers, :genres)
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
