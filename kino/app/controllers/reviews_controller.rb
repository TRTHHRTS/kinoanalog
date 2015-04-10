class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]

  # GET
  def show
  end

  # GET
  def new_review
    @review = Review.new(review_params)
    @movie_title = Movie.find(@review.movie_id).title
  end

  # POST
  def create_review
    @review = Review.new(review_params)
    @review.id=Review.last.id+1
    respond_to do |format|
      if @review.save
        format.html { redirect_to '/details/'+@review.movie_id.to_s, notice: 'Review was successfully created.' }
      else
        format.html { render action: 'new_review' }
      end
    end
  end

  # GET
  def edit_review
    @review = Review.find(params[:id])
    @movie_title = Movie.find(@review.movie_id).title
  end

  # PATCH/PUT
  def update_review
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to '/details/'+@review.movie_id.to_s, notice: 'Review was successfully updated.' }
      else
        format.html { render action: 'edit_review' }
      end
    end
  end

  # DELETE
  def destroy_review
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
    def set_review
      @review = Review.find(review_params[:id])
    end

    def review_params
      params.require(:review).permit(:id, :movie_id, :user_id, :title, :review_date, :content, :recommended)
    end
end
