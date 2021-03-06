class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]
  before_action :check_only_admin_user, only: [:edit_review, :update_review, :destroy_review]
  before_action :check_only_registered, only: [:new_review, :create_review]

  # GET
  def show
  end

  # GET
  def new_review
    @review = Review.new(review_params)
    @movie_title = Movie.find(@review.movie_id).title
    respond_to do |format|
      format.js
    end
  end

  # POST
  def create_review
    @review = Review.new(review_params)
    @review.id=Review.last.id+1
    @movie=Movie.find(@review.movie_id)
    respond_to do |format|
      if @review.save
        flash.now[:notice] = 'Отзыв успешно сохранен'
        format.js
      else
        flash.now[:notice] = 'Что-то пошло не так.. проверьте правильность заполнения полей'
        format.js { render action: 'new_review' }
      end
    end
  end

  # GET
  def edit_review
    @review = Review.find(params[:id])
    @movie_title = Movie.find(@review.movie_id).title
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT
  def update_review
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        flash.now[:notice] = 'Отзыв обновлен'
        format.js
      else
        format.js { render action: 'edit_review' }
      end
    end
  end

  # DELETE
  def destroy_review
    @review = Review.find(params[:id])
    @review_id=@review.id
    @movie=Movie.find(@review.movie_id)
    @review.destroy
    respond_to do |format|
      flash.now[:notice] = 'Отзыв удален'
      format.js
    end
  end

  private
    def set_review
      @review = Review.find(review_params[:id])
    end

    def review_params
      params.require(:review).permit(:id, :movie_id, :user_id, :title, :review_date, :content, :recommended)
    end

  def check_only_admin_user
    userId = Review.find(params[:id]).user_id
    if !user_signed_in? || (current_user.permission != 1 && current_user.id != userId )
      render_404
    end
  end

  def check_only_registered
    unless user_signed_in?
      render_404
    end
  end

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end
