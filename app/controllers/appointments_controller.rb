class AppointmentsController < ApplicationController
  before_action -> { authorized("patient") }, only: [:create]



  # GET /appointments
  def index
    @appointments = Appointment.all

    render json: @appointments
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  def find_by_patient
    set_appointment_by_patient
    if @appointment
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def find_by_date_and_patient_gender
    date = params[:date]
    gender = params[:gender]

    if date.present? && gender.present?
      appointments = Appointment.joins(:patient)
                                .where(appointment_date: date, patients: { gender: gender })
      render json: appointments, status: :ok
    else
      render json: { error: "Date and gender parameters are required" }, status: :unprocessable_entity
    end
  end

  def confirm_appointment
    @appointments = Appointment.where(appointment_status: "pending")
    render json: @appointments
  end

  def nurse_confirm_appointment
    set_appointment_by_appointment_id
    if @appointment
      @patient = Patient.find(@appointment.patient_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your appointment has been confirmed. Please come to the hospital on #{@appointment.appointment_date}."
      @appointment.update(appointment_status: "confirmed", nurse_id: params[:nurse_id])

      # Send SMS
      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @appointment
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def make_reschedule
    set_appointment_by_patient
    if @appointment
      @appointment.update(appointment_status: "to reschedule", appointment_date: params[:appointment_date])
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def make_reschedule_table
    @appointments = Appointment.where(appointment_status: "to reschedule")
    render json: @appointments
  end

  def make_reschedule_done
    set_appointment_by_appointment_id
    if @appointment
      @patient = Patient.find(@appointment.patient_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your request to reschedule appointment has been confirmed. Please come to the hospital on #{@appointment.appointment_date}."
      @appointment.update(appointment_status: "confirmed")

      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @appointment
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def ongoing_appointment
    @appointments = Appointment.where(appointment_status: ["confirmed", "to diagnose"])
    render json: @appointments
  end

  def make_appointment_done
    set_appointment_by_patient
    if @appointment
      @appointment.update(appointment_status: "done")
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def finished_appointment
    @appointments = Appointment.where(appointment_status: "done")
    render json: @appointments
  end

  def nurse_make_test_done
    set_appointment_by_patient

    if @appointment
      if @appointment.update(fbc_status: true, bp_status: true, bmt_date: params[:bmt_date])
        @patient = Patient.find(@appointment.patient_id)
        formatted_number = format_phone_number(@patient.telephone)
        text = "Your Initial Bone Marrow Test is scheduled on #{@appointment.bmt_date}. Please come to the hospital on that day."

        response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                                 body: { to: formatted_number, text: text })

        if response.success?
          render json: @appointment
        else
          render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Failed to update appointment' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Appointment not found' }, status: :not_found
    end
  end

  def nurse_make_to_diagnose
    set_appointment_by_patient
    if @appointment
      @appointment.update(fbc_report: params[:fbc_report], bp_report: params[:bp_report], bmt_report: params[:bmt_report], appointment_status: "to diagnose")
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def last_appointment_by_patient_id
    @appointment = Appointment.where(patient_id: params[:patient_id]).order(appointment_date: :desc).first
    if @appointment
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end


  def nurse_unfinished_appointments
    @appointments = Appointment.where(appointment_status: %w[pending confirmed])
    render json: @appointments
  end




  def find_by_appointment_id
    set_appointment_by_appointment_id
    if @appointment
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def find_by_patient_id
    set_appointment_by_patient
    if @appointment
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
  end

  def delete_by_appointment_id
    set_appointment_by_appointment_id
    if @appointment
      @appointment.destroy
      render json: { message: 'Appointment deleted successfully' }, status: :ok
    else
      render json: { error: "Appointment with ID #{params[:appointment_id]} not found" }, status: :not_found
    end
  end

  private

  def set_appointment_by_patient
    @appointment = Appointment.find_by(patient_id: params[:patient_id])
  end

  def set_appointment_by_appointment_id
    @appointment = Appointment.find_by(appointment_id: params[:appointment_id])
  end
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:appointment_date, :appointment_status, :bmt_date, :fbc_status, :bp_status, :bmt_report, :fbc_report, :bp_report, :patient_id, :nurse_id)
    end
end
