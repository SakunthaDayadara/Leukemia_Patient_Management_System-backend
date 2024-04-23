class PatientsController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def auto_login
    render json: {patient_id: @current_user.patient_id, username: @current_user.username }, status: :ok
  end

  def login
    @patient = Patient.find_by(username: params[:username])
    if @patient&.authenticate(params[:password])
      token = JsonWebToken.encode(patient_id: @patient.patient_id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     patient_id: @patient.patient_id }, status: :ok
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
    set_patient_by_patient_id
    @patient.destroy
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
      params.require(:patient).permit(:dob, :nic, :address, :gender, :username, :password, :first_name, :last_name)
    end

    def logged_in_user
      if decoded_token
        patient_id = decoded_token[0]['patient_id']
        @patient = Patient.find_by(patient_id: patient_id)
      end
    end



    def authorized
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = Patient.find(@decoded[:patient_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
end
