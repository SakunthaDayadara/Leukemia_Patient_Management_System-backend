class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show update destroy ]

  # GET /clinics
  def index
    @clinics = Clinic.all

    render json: @clinics
  end

  # GET /clinics/1
  def show
    render json: @clinic
  end

  # POST /clinics
  def create
    patient_id = clinic_params[:patient_id]
    last_clinic = Clinic.where(patient_id: patient_id).order(clinic_date: :desc).first


    @clinic = Clinic.new(clinic_params)
    @clinic.last_clinic_date = last_clinic&.clinic_date

    if @clinic.save
      @patient = Patient.find(@clinic.patient_id)
      @doctor = Doctor.find(@clinic.doctor_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your #{@clinic.clinic_type} Clinic with #{@doctor.name} has been scheduled. Please come to the hospital on #{@clinic.clinic_date}."


      # Send SMS
      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @clinic, status: :created, location: @clinic
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clinics/1
  def update
    if @clinic.update(clinic_params)
      render json: @clinic
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clinics/1
  def destroy
    @clinic.destroy
  end

  def doctor_schedule_clinic_table
    @clinics = Clinic.where(clinic_status: 'scheduled').where(doctor_id: params[:doctor_id])
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No scheduled clinics found'}
    end
  end

  def doctor_reschedule_clinic
    @clinic = Clinic.find(params[:clinic_id])
    if @clinic.update(clinic_date: params[:clinic_date])
      @patient = Patient.find(@clinic.patient_id)
      @doctor = Doctor.find(@clinic.doctor_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your #{@clinic.clinic_type} Clinic with #{@doctor.name} has been rescheduled to #{@clinic.clinic_date}."


      # Send SMS
      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @clinic
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  def nurse_schedule_clinic_table
    @clinics = Clinic.where(clinic_status: 'scheduled')
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No scheduled clinics found'}
    end
  end

  def nurse_make_clinic_ongoing
    @clinic = Clinic.find(params[:clinic_id])
    if @clinic.update(clinic_status: 'ongoing', nurse_id: params[:nurse_id])
      render json: @clinic
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  def doctor_ongoing_clinic_table
    @clinics = Clinic.where(clinic_status: 'ongoing').where(doctor_id: params[:doctor_id])
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No ongoing clinics found'}
    end
  end

  def nurse_on_going_clinic_table
    @clinics = Clinic.where(clinic_status: 'ongoing')
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No ongoing clinics found'}
    end
  end

  def doctor_complete_clinic
    @clinic = Clinic.find(params[:clinic_id])
    if @clinic.update(clinic_status: 'completed', clinic_notes: params[:clinic_notes])
      render json: @clinic
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  def doctor_unfinished_clinic_table
    @clinics = Clinic.where(clinic_status: %w[ongoing scheduled]).where(doctor_id: params[:doctor_id])
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No ongoing clinics found'}
    end
  end

  def clinic_by_patient_id
    @clinics = Clinic.where(patient_id: params[:patient_id]).where(clinic_status: 'completed')
    if @clinics
      render json: @clinics
    else
      render json: {error: 'No clinics found'}
    end
  end

  def last_clinic_by_patient_id
    @clinic = Clinic.where(patient_id: params[:patient_id]).order(clinic_date: :desc).first
    if @clinic
      render json: @clinic
    else
      render json: {error: 'No clinic found'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clinic_params
      params.require(:clinic).permit(:clinic_date, :last_clinic_date, :clinic_type, :clinic_status, :doctor_id, :patient_id, :nurse_id, :clinic_notes)
    end
end
