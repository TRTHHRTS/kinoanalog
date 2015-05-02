class MoviesController < ApplicationController
  before_action :fill_movie_by_params, only: [:create_movie, :update_movie]
  before_action :movie_params, only: [:create_movie, :update_movie]
  before_action :check_only_admin_moder, only: [:new_movie, :create_movie, :edit_movie, :update_movie, :destroy_movie]

  # GET
  def new_movie
    @movie = Movie.new
  end

  # GET
  def edit_movie
    @movie = Movie.find(params[:id])
    params[:title] = @movie.title
    params[:orig_title] = @movie.orig_title
    params[:release_date] = @movie.release_date
    params[:duration] = @movie.duration
    params[:age_id] = @movie.age_id
    params[:description] = @movie.description
  end

  # POST
  def create_movie
    @movie.id = Movie.last.id + 1
    @movie.age_id = params[:movie][:age_id]
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
    @movieFromDb = Movie.find(params[:id])
    @movie.image_url = @movieFromDb.image_url
    @movie.id = @movieFromDb.id
    @movie.age_id = params[:movie][:age_id]
    # Сохранение постера
    poster = params[:file][:poster] unless params[:file].nil?
    unless poster.nil?
      unless @movie.image_url.split('/').include? 'noposter.png'
        File.delete('public' + @movie.image_url)
      end
      extension = poster.original_filename.split('.').last
      directory = '/assets/images/movies'
      path = File.join(directory, @movie.id.to_s + '.' + extension)
      File.open('public'+path, 'wb') { |f| f.write(poster.read) }
      @movie.image_url = path
      params[:file].delete(:poster)
    end
    respond_to do |format|
      if @movieFromDb.update(@movie.attributes)
        if @movieFromDb.update_attributes(countries: @movie.countries, genres: @movie.genres,
                                          stars: @movie.stars, directors: @movie.directors, producers: @movie.producers, writers: @movie.writers)
          format.html { redirect_to '/details/'+@movie.id.to_s, notice: 'Информация о фильме успешно изменена' }
      end
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

  #select POST_JS
  def add_rating
    rated = Rating.find_by(user_id: params[:user_id], movie_id: params[:movie_id])
    unless rated
      @rating = Rating.new
      @rating.movie_id = params[:movie_id]
      @rating.user_id = params[:user_id]
      @rating.value = params[:rating_value]
      @rating.id=Rating.last.id+1
      @movie=Movie.find(@rating.movie_id)
      respond_to do |format|
        if @rating.save
          format.js {render action: 'process_rating', notice: 'Спасибо, мы учли твой голос!' }
        else
          format.js { render action: 'process_rating', notice: 'Что-то пошло не так..' }
        end
      end
    end
  end

  private

  # Заполнить сущность Movie параметрами из добавления или из редактирования
    def fill_movie_by_params
      @movie = Movie.new

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
            if v == '-1'
              star = Star.new(name: k)
            else
              star = Star.new(name: k, url: v)
            end
            star.save
          else
            if star.url.nil? && v != '-1'
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
            if v == '-1'
              director = Director.new(name: k)
            else
              director = Director.new(name: k, url: v)
            end
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
            if v == '-1'
              producer = Producer.new(name: k)
            else
              producer = Producer.new(name: k, url: v)
            end
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
            if v == '-1'
              writer = Writer.new(name: k)
            else
              writer = Writer.new(name: k, url: v)
            end
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
