class PatientsController < ApplicationController
  before_action -> { authorized("patient") }, only: [:auto_login,]
  before_action -> { authorized(%w[nurse doctor]) }, only: [:update]

  def auto_login
    render json: {username: @current_user.username, user_id: @current_user.patient_id , role: @decoded[:role] }, status: :ok
  end

  def index
    @patients = Patient.all

    render json: @patients
  end


  def make_appointment
    set_patient_by_patient_id
    if @patient.update(appointment_status: true)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def initial_appointment
    @patients = Patient.where(appointment_status: true).where(permanent_status: false).where(admission_status: "appointment").where(diagnose_status: false)
    render json: @patients
  end

  def make_test_done
    set_patient_by_patient_id
    if @patient.update(admission_status: "test_done", blood_type: params[:blood_type])
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end


  def test_done
    @patients = Patient.where(admission_status: "test_done").where(appointment_status: true).where(permanent_status: false).where(diagnose_status: false)
    render json: @patients
  end

  def make_to_diagnose
    set_patient_by_patient_id
    if @patient.update(admission_status: "to_diagnose")
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end


  def to_diagnose
    @patients = Patient.where(admission_status: "to_diagnose").where(appointment_status: true).where(permanent_status: false).where(diagnose_status: false)
    render json: @patients
  end

  def doctor_make_diagnose
    set_patient_by_patient_id
    if @patient.update(admission_status: "diagnose_done", current_diagnose: params[:current_diagnose], diagnose_status: true)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def to_admit_table
    @patients = Patient.where(admission_status: "diagnose_done").where(appointment_status: true).where(permanent_status: false).where(current_diagnose: "cancer_patient").where(diagnose_status: true)
    render json: @patients
  end

  def nurse_admit_patient
    set_patient_by_patient_id
    if @patient.update(admission_status: "admitted", bht_number: params[:bht_number], accommodation_type: "admitted", permanent_status: true, stage_of_treatment: "initial_admitted")
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def admitted_patients
    @patients = Patient.where(admission_status: "admitted").where(appointment_status: true).where(permanent_status: true).where(accommodation_type: "admitted").where(diagnose_status: true).where(current_diagnose: %w[cancer_patient advance_cancer_patient])
    render json: @patients
  end

  def discharge_patient
    set_patient_by_patient_id
    if @patient.update(admission_status: "clinic", accommodation_type: params[:accommodation_type], stage_of_treatment: "clinic")
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def doctor_categorize_table
    @patients = Patient.where(admission_status: "admitted").where(appointment_status: true).where(permanent_status: true).where(accommodation_type: "admitted").where(diagnose_status: true).where(current_diagnose: "cancer_patient").where(advance_diagnose_status: false)
    render json: @patients
  end

  def doctor_make_categorize
    set_patient_by_patient_id
    if @patient.update(advance_diagnose_status: true, stage_of_treatment: "categorize_done", current_diagnose: "advance_cancer_patient", treatment_status: true)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def doctor_change_category_treatment_table
    @patients = Patient.where(admission_status: "admitted").where(appointment_status: true).where(permanent_status: true).where(stage_of_treatment: "categorize_done").where(diagnose_status: true).where(current_diagnose: "advance_cancer_patient").where(advance_diagnose_status: true).where(treatment_status: true)
    render json: @patients
  end


  def doctor_make_treatment_pause
    set_patient_by_patient_id
    if @patient.update(treatment_status: false)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def doctor_resume_treatment_table
    @patients = Patient.where(admission_status: "admitted").where(appointment_status: true).where(permanent_status: true).where(stage_of_treatment: "categorize_done").where(diagnose_status: true).where(current_diagnose: "advance_cancer_patient").where(advance_diagnose_status: true).where(treatment_status: false)
    render json: @patients
  end

  def doctor_make_treatment_resume
    set_patient_by_patient_id
    if @patient.update(treatment_status: true)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end









  def login

    @patient = Patient.find_by(username: params[:username])
    if @patient&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @patient.patient_id, role: "patient")
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     patient_id: @patient.patient_id, role: "patient" }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
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
    set_patient_by_patient_id
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    set_patient
    @patient.destroy
  end

  def delete_by_patient_id
    set_patient_by_patient_id
    if @patient
      @patient.destroy
      render json: { message: 'Patient deleted successfully' }, status: :ok
    else
      render json: { error: "Patient with ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def find_by_patient_id
    @patient = Patient.find_by(patient_id: params[:patient_id])
    if @patient
      render json: @patient
    else
      render json: { error: "Patient not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

  def set_patient_by_patient_id
    @patient = Patient.find_by(patient_id: params[:patient_id])
  end


    # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:patient).permit(:dob, :nic, :address, :gender, :username, :password, :first_name, :last_name, :telephone, :permanent_status, :diagnose_status, :appointment_status, :blood_type, :admission_status, :bht_number, :current_diagnose, :stage_of_treatment, :accommodation_type, :advance_diagnose_status, :treatment_status)
  end


end
