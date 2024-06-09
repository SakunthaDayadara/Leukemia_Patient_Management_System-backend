class ReferencesController < ApplicationController
  before_action :set_reference, only: %i[ show update destroy ]

  # GET /references
  def index
    @references = Reference.all

    render json: @references
  end

  # GET /references/1
  def show
    render json: @reference
  end

  # POST /references
  def create
    @reference = Reference.new(reference_params)

    if @reference.save
      render json: @reference, status: :created, location: @reference
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /references/1
  def update
    if @reference.update(reference_params)
      render json: @reference
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end

  # DELETE /references/1
  def destroy
    @reference.destroy
  end

  def find_by_reference_id
    set_by_reference_id
    if @reference
      render json: @reference
    else
      render json: { error: "Reference not found" }, status: :not_found
    end
  end

  def find_by_patient_id
    @references = Reference.where(patient_id: params[:patient_id]).where(reference_status: 'done')
    if @references
      render json: @references
    else
      render json: { error: "Reference not found" }, status: :not_found
    end
  end

  def find_by_doctor_id
    @references = Reference.where(doctor_id: params[:doctor_id])
    if @references
      render json: @references
    else
      render json: { error: "Reference not found" }, status: :not_found
    end
  end

  def doctor_incoming_references
    @references = Reference.where(referred_doctor_id: params[:referred_doctor_id]).where(reference_status: 'pending')
    if @references
      render json: @references
    else
      render json: { error: "Reference not found" }, status: :not_found
    end
  end

  def doctor_make_reference_done
    @reference = Reference.find(params[:reference_id])
    if @reference.update(reference_status: 'done', referred_doctor_notes: params[:referred_doctor_notes])
      render json: @reference
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    def set_by_reference_id
      @reference = Reference.find_by(reference_id: params[:reference_id])
    end



    # Only allow a list of trusted parameters through.
    def reference_params
      params.require(:reference).permit(:reference_id, :reference_note, :referred_doctor_id, :referred_doctor_notes, :reference_status, :doctor_id, :patient_id)
    end
end
