class TreatmentRecordsController < ApplicationController
  before_action :set_treatment_record, only: %i[ show update destroy ]

  # GET /treatment_records
  def index
    @treatment_records = TreatmentRecord.all

    render json: @treatment_records
  end

  # GET /treatment_records/1
  def show
    render json: @treatment_record
  end

  # POST /treatment_records
  def create
    @treatment_record = TreatmentRecord.new(treatment_record_params)

    if @treatment_record.save
      render json: @treatment_record, status: :created, location: @treatment_record
    else
      render json: @treatment_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treatment_records/1
  def update
    if @treatment_record.update(treatment_record_params)
      render json: @treatment_record
    else
      render json: @treatment_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treatment_records/1
  def destroy
    @treatment_record.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_record
      @treatment_record = TreatmentRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def treatment_record_params
      params.require(:treatment_record).permit(:treatment_record_id, :treatment_status, :treatment_date, :last_treatment_date, :treatment_notes, :nurse_id, :patient_id, :treatment_id)
    end
end
