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
    patient_id = treatment_record_params[:patient_id]
    last_treatment_record = TreatmentRecord.where(patient_id: patient_id).order(treatment_date: :desc).first

    @treatment_record = TreatmentRecord.new(treatment_record_params)
    @treatment_record.last_treatment_date = last_treatment_record&.treatment_date

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

  def find_by_patient_id
    @treatment_records = TreatmentRecord.where(patient_id: params[:patient_id])
    if @treatment_records
      render json: @treatment_records
    else
      render json: { error: "Treatment Record not found" }, status: :not_found
    end
  end

  def find_by_nurse_id
    @treatment_records = TreatmentRecord.where(nurse_id: params[:nurse_id]).where(treatment_status: false)
    if @treatment_records
      render json: @treatment_records
    else
      render json: { error: "Treatment Record not found" }, status: :not_found
    end
  end

  def nurse_confirm_treatment_record
    @treatment_record = TreatmentRecord.find(params[:treatment_record_id])
    if @treatment_record.update(treatment_status: true)
      render json: @treatment_record
    else
      render json: @treatment_record
    end
  end

  def treatment_records_by_patient_id
    @treatment_records = TreatmentRecord.where(patient_id: params[:patient_id]).where(treatment_status: true)
    if @treatment_records
      render json: @treatment_records
    else
      render json: { error: "Treatment Record not found" }, status: :not_found
    end
  end

  def last_treatment_record_by_patient_id
    @treatment_record = TreatmentRecord.where(patient_id: params[:patient_id]).order(treatment_date: :desc).first
    if @treatment_record
      render json: @treatment_record
    else
      render json: { error: "Treatment Record not found" }, status: :not_found
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_record
      @treatment_record = TreatmentRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def treatment_record_params
      params.require(:treatment_record).permit(:treatment_status, :treatment_date, :last_treatment_date, :treatment_notes, :nurse_id, :patient_id, :treatment_id)
    end
end
