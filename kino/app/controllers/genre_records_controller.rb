class GenreRecordsController < ApplicationController
  before_action :set_genre_record, only: [:show, :edit, :update, :destroy]

  # GET /genre_records
  # GET /genre_records.json
  def index
    @genre_records = GenreRecord.all
  end

  # GET /genre_records/1
  # GET /genre_records/1.json
  def show
  end

  # GET /genre_records/new
  def new
    @genre_record = GenreRecord.new
  end

  # GET /genre_records/1/edit
  def edit
  end

  # POST /genre_records
  # POST /genre_records.json
  def create
    @genre_record = GenreRecord.new(genre_record_params)

    respond_to do |format|
      if @genre_record.save
        format.html { redirect_to @genre_record, notice: 'Genre record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @genre_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @genre_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genre_records/1
  # PATCH/PUT /genre_records/1.json
  def update
    respond_to do |format|
      if @genre_record.update(genre_record_params)
        format.html { redirect_to @genre_record, notice: 'Genre record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @genre_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genre_records/1
  # DELETE /genre_records/1.json
  def destroy
    @genre_record.destroy
    respond_to do |format|
      format.html { redirect_to genre_records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre_record
      @genre_record = GenreRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genre_record_params
      params[:genre_record]
    end
end
