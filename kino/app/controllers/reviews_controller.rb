class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new_review
    @review = Review.new(review_params)
    @movie_title = Movie.find(@review.movie_id).title
  end

  def create_review
    @review = Review.new(review_params)
    @review.id=Review.last.id+1
    respond_to do |format|
      if @review.save
        format.html { redirect_to '/details/'+@review.movie_id.to_s, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /reviews/1/edit
  def edit_review
    @review = Review.find(params[:id])
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update_review
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to '/details/'+@review.movie_id.to_s, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy_review
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(review_params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:id, :movie_id, :user_id, :title, :review_date, :content, :isgood, :mark)
    end
end
