class BedsController < ApplicationController
  before_action :set_bed, only: %i[ show update destroy ]

  # GET /beds
  def index
    @beds = Bed.all

    render json: @beds
  end

  # GET /beds/1
  def show
    render json: @bed
  end

  # POST /beds
  def create
    @bed = Bed.new(bed_params)

    if @bed.save
      render json: @bed, status: :created, location: @bed
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beds/1
  def update
    if @bed.update(bed_params)
      render json: @bed
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beds/1
  def destroy
    @bed.destroy
  end

  def get_available_beds_by_ward
    @beds = Bed.where(ward_num: params[:ward_num]).where(is_occupied: false)
    render json: @beds
  end

  def admit_patient
    @bed = Bed.find_by(bed_id: params[:bed_id])
    if @bed
      @bed.update(patient_id: params[:patient_id], is_occupied: true)
      render json: { message: 'Patient admitted successfully' }, status: :ok
    else
      render json: { error: "Bed with ID #{params[:bed_id]} not found" }, status: :not_found
    end
  end

  def discharge_patient
    @bed = Bed.find_by(bed_id: params[:bed_id])
    if @bed
      @bed.update(patient_id: nil, is_occupied: false)
      render json: { message: 'Patient discharged successfully' }, status: :ok
    else
      render json: { error: "Bed with ID #{params[:bed_id]} not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bed
      @bed = Bed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bed_params
      params.require(:bed).permit(:bed_id, :ward_num, :is_occupied, :patient_id)
    end
end
