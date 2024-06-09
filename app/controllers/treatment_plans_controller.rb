class TreatmentPlansController < ApplicationController
  before_action :set_treatment_plan, only: %i[ show update destroy ]

  # GET /treatment_plans
  def index
    @treatment_plans = TreatmentPlan.all

    render json: @treatment_plans
  end

  # GET /treatment_plans/1
  def show
    render json: @treatment_plan
  end

  # POST /treatment_plans
  def create
    @treatment_plan = TreatmentPlan.new(treatment_plan_params)

    if @treatment_plan.save
      render json: @treatment_plan, status: :created, location: @treatment_plan
    else
      render json: @treatment_plan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treatment_plans/1
  def update
    if @treatment_plan.update(treatment_plan_params)
      render json: @treatment_plan
    else
      render json: @treatment_plan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treatment_plans/1
  def destroy
    @treatment_plan.destroy
  end

  def find_by_treatment_id
    set_treatment_plan_by_treatment_id
    if @treatment_plan
      render json: @treatment_plan
    else
      render json: { error: "Treatment with ID #{params[:treatment_id]} not found" }, status: :not_found
    end
  end


  def find_by_doctor_id
    set_treatment_plan_by_doctor_id
    if @treatment_plan
      render json: @treatment_plan
    else
      render json: { error: "Treatment with doctor ID #{params[:doctor_id]} not found" }, status: :not_found
    end
  end

  def find_by_patient_id
    set_treatment_plan_by_patient_id
    if @treatment_plan
      render json: @treatment_plan
    else
      render json: { error: "Treatment with patient ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def find_by_diagnose_id
    set_treatment_plan_by_diagnose_id
    if @treatment_plan
      render json: @treatment_plan
    else
      render json: { error: "Treatment with diagnose ID #{params[:diagnose_id]} not found" }, status: :not_found
    end
  end

  def doctor_pause_treatment
    set_treatment_plan_by_patient_id
    if @treatment_plan
      @treatment_plan.update(treatment_status: "paused")
      render json: { message: "Treatment paused successfully" }, status: :ok
    else
      render json: { error: "Treatment with doctor ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def doctor_resume_treatment
    set_treatment_plan_by_patient_id
    if @treatment_plan
      @treatment_plan.update(treatment_status: "ongoing")
      render json: { message: "Treatment resumed successfully" }, status: :ok
    else
      render json: { error: "Treatment with doctor ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def doctor_change_treatment_type
    set_treatment_plan_by_patient_id
    if @treatment_plan
      @treatment_plan.update(treatment_type: params[:treatment_type])
      render json: { message: "Treatment type changed successfully" }, status: :ok
    else
      render json: { error: "Treatment with doctor ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end

  def doctor_finish_treatment
    set_treatment_plan_by_patient_id
    if @treatment_plan
      @treatment_plan.update(treatment_status: "finished")
      render json: { message: "Treatment finished successfully" }, status: :ok
    else
      render json: { error: "Treatment with doctor ID #{params[:patient_id]} not found" }, status: :not_found
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_plan
      @treatment_plan = TreatmentPlan.find(params[:id])
    end

  def set_treatment_plan_by_treatment_id
    @treatment_plan = TreatmentPlan.find_by(treatment_id: params[:treatment_id])
  end

  def set_treatment_plan_by_doctor_id
    @treatment_plan = TreatmentPlan.find_by(doctor_id: params[:doctor_id])
  end

  def set_treatment_plan_by_patient_id
    @treatment_plan = TreatmentPlan.find_by(patient_id: params[:patient_id])
  end


  def set_treatment_plan_by_diagnose_id
    @treatment_plan = TreatmentPlan.find_by(diagnose_id: params[:diagnose_id])
  end


    # Only allow a list of trusted parameters through.
    def treatment_plan_params
      params.require(:treatment_plan).permit(:treatment_type, :treatment_status, :doctor_id, :patient_id, :diagnose_id)
    end
end
