class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show update destroy ]

  # GET /admins
  def index
    @admins = Admin.all

    render json: @admins
  end

  # GET /admins/1
  def show
    render json: @admin
  end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render json: @admin, status: :created, location: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admins/1
  def update
    if @admin.update(admin_params)
      render json: @admin
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admins/1
  def destroy
    @admin.destroy
  end

  def find_by_admin_id
    set_admin_by_admin_id
    if @admin
      render json: @admin
    else
      render json: { error: "Admin not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

  def set_admin_by_admin_id
    @admin = Admin.find_by(admin_id: params[:admin_id])
  end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:name, :username, :password)
    end
end
