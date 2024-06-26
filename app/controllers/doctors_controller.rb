class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[ show update destroy ]
  before_action -> { authorized("admin") }, only: [:create]

  # GET /doctors
  def index
    @doctors = Doctor.all

    render json: @doctors
  end

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      render json: @doctor, status: :created, location: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
  end

  def find_by_doctor_id
    set_doctor_by_doctor_id
    if @doctor
      render json: @doctor
    else
      render json: { error: "Doctor not found" }, status: :not_found
    end
  end

  def reset_password
    set_doctor_by_doctor_id
    if @doctor.update(password: params[:password])
      render json: { message: "Password reset successfully" }, status: :ok
    else
      render json: { error: "Password reset failed" }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

  def set_doctor_by_doctor_id
    @doctor = Doctor.find_by(doctor_id: params[:doctor_id])
  end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :username, :password)
    end
end
