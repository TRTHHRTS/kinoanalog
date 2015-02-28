class CountryRecordsController < ApplicationController
  before_action :set_country_record, only: [:show, :edit, :update, :destroy]

  # GET /country_records
  # GET /country_records.json
  def index
    @country_records = CountryRecord.all
  end

  # GET /country_records/1
  # GET /country_records/1.json
  def show
  end

  # GET /country_records/new
  def new
    @country_record = CountryRecord.new
  end

  # GET /country_records/1/edit
  def edit
  end

  # POST /country_records
  # POST /country_records.json
  def create
    @country_record = CountryRecord.new(country_record_params)

    respond_to do |format|
      if @country_record.save
        format.html { redirect_to @country_record, notice: 'Country record was successfully created.' }
        format.json { render action: 'show', status: :created, location: @country_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @country_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /country_records/1
  # PATCH/PUT /country_records/1.json
  def update
    respond_to do |format|
      if @country_record.update(country_record_params)
        format.html { redirect_to @country_record, notice: 'Country record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @country_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /country_records/1
  # DELETE /country_records/1.json
  def destroy
    @country_record.destroy
    respond_to do |format|
      format.html { redirect_to country_records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country_record
      @country_record = CountryRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_record_params
      params[:country_record]
    end
end
