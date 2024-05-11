class NursesController < ApplicationController
  before_action :set_nurse, only: %i[ show update destroy ]
  before_action -> { authorized("admin") }, only: [:create]

  # GET /nurses
  def index
    @nurses = Nurse.all

    render json: @nurses
  end

  # GET /nurses/1
  def show
    render json: @nurse
  end

  # POST /nurses
  def create
    @nurse = Nurse.new(nurse_params)

    if @nurse.save
      render json: @nurse, status: :created, location: @nurse
    else
      render json: @nurse.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /nurses/1
  def update
    if @nurse.update(nurse_params)
      render json: @nurse
    else
      render json: @nurse.errors, status: :unprocessable_entity
    end
  end

  # DELETE /nurses/1
  def destroy
    @nurse.destroy
  end

  def find_by_nurse_id
    set_nurse_by_nurse_id
    if @nurse
      render json: @nurse
    else
      render json: { error: "Nurse not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nurse
      @nurse = Nurse.find(params[:id])
    end

  def set_nurse_by_nurse_id
    @nurse = Nurse.find_by(nurse_id: params[:nurse_id])
  end

    # Only allow a list of trusted parameters through.
    def nurse_params
      params.require(:nurse).permit(:name, :username, :password, :ward_num)
    end
end
