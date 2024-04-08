class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show update destroy ]


  # GET /patients
  def index
    @patients = Patient.all

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      render json: { patient_id: @patient.patient_id , message: "Patient created successfully" }, status: :created
    else
      render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:dob, :nic, :address, :gender, :username, :password, :first_name, :last_name)
    end
end
