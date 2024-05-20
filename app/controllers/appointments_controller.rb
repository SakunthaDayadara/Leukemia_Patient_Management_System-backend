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
      @appointment.update(appointment_status: "confirmed", nurse_id: params[:nurse_id])
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def make_reschedule
    set_appointment_by_appointment_id
    if @appointment
      @appointment.update(appointment_status: "To reschedule")
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
      @appointment.update(appointment_status: "confirmed")
      render json: @appointment
    else
      render json: { error: "Appointment not found" }, status: :not_found
    end
  end

  def ongoing_appointment
    @appointments = Appointment.where(appointment_status: "confirmed")
    render json: @appointments
  end

  def make_appointment_done
    set_appointment_by_appointment_id
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




  def find_by_appointment_id
    set_appointment_by_appointment_id
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
    @appointment = Appointment.where(patient_id: params[:patient_id])
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
