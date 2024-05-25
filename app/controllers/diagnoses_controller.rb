class DiagnosesController < ApplicationController
  before_action :set_diagnosis, only: %i[ show update destroy ]

  # GET /diagnoses
  def index
    @diagnoses = Diagnosis.all

    render json: @diagnoses
  end

  # GET /diagnoses/1
  def show
    render json: @diagnosis
  end

  # POST /diagnoses
  def create
    @diagnosis = Diagnosis.new(diagnosis_params)

    if @diagnosis.save
      render json: @diagnosis, status: :created, location: @diagnosis
    else
      render json: @diagnosis.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diagnoses/1
  def update
    if @diagnosis.update(diagnosis_params)
      render json: @diagnosis
    else
      render json: @diagnosis.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diagnoses/1
  def destroy
    @diagnosis.destroy
  end

  def find_by_diagnose_id
  set_diagnosis_by_diagnose_id
    if @diagnosis
      render json: @diagnosis
    else
      render json: { error: "Diagnosis with ID #{params[:diagnose_id]} not found" }, status: :not_found
    end
  end

  def find_by_patient_id
    set_diagnosis_by_patient_id
    if @diagnosis
      render json: @diagnosis
    else
      render json: { error: "Diagnosis with patient ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def find_by_doctor_id
    set_diagnosis_by_doctor_id
    if @diagnosis
      render json: @diagnosis
    else
      render json: { error: "Diagnosis with doctor ID #{params[:doctor_id]} not found" }, status: :not_found
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagnosis
      @diagnosis = Diagnosis.find(params[:id])
    end

  def set_diagnosis_by_diagnose_id
    @diagnosis = Diagnosis.find_by(diagnose_id: params[:diagnose_id])
  end

  def set_diagnosis_by_patient_id
    @diagnosis = Diagnosis.find_by(patient_id: params[:patient_id])
  end

  def set_diagnosis_by_doctor_id
    @diagnosis = Diagnosis.find_by(doctor_id: params[:doctor_id])
  end


    # Only allow a list of trusted parameters through.
    def diagnosis_params
      params.require(:diagnosis).permit(:category, :doctor_notes, :doctor_id, :patient_id)
    end
end
