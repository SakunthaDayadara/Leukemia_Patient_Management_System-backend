class TestsController < ApplicationController
  before_action :set_test, only: %i[ show update destroy ]

  # GET /tests
  def index
    @tests = Test.all

    render json: @tests
  end

  # GET /tests/1
  def show
    render json: @test
  end

  # POST /tests
  def create
    @test = Test.new(test_params)

    if @test.save
      render json: @test, status: :created, location: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tests/1
  def update
    if @test.update(test_params)
      render json: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tests/1
  def destroy
    @test.destroy
  end

  def requested_tests
    @tests = Test.where(test_status: "requested")
    if @tests
      render json: @tests
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end


  def nurse_make_test_scheduled
    @test = Test.find(params[:test_id])
    if @test
      @test.update(test_status: "scheduled", nurse_id: params[:nurse_id], test_date: params[:test_date], test_place: params[:test_place])
      @patient = Patient.find(@test.patient_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your test for #{@test.test_type} has been scheduled for #{@test.test_date}. Please come to #{@test.test_place} on that day."

      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @test
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end


  def scheduled_tests
    @tests = Test.where(test_status: "scheduled")
    if @tests
      render json: @tests
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end

  def nurse_reschedule_test
    @test = Test.find(params[:test_id])
    if @test
      @test.update(test_date: params[:test_date])
      @patient = Patient.find(@test.patient_id)
      formatted_number = format_phone_number(@patient.telephone)
      text = "Your #{@test.test_type} Test has been rescheduled for #{@test.test_date}. Please come to #{@test.test_place} on that day."

      response = HTTParty.post("#{ENV['BACKEND_URL']}/send_sms",
                               body: { to: formatted_number, text: text })

      if response.success?
        render json: @test
      else
        render json: { error: 'Failed to send SMS' }, status: :unprocessable_entity
      end
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  def doctor_pending_test
    @tests = Test.where(test_status: %w[scheduled requested]).where(doctor_id: params[:doctor_id])
    if @tests
      render json: @tests
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end


  def find_by_patient_id
    @tests = Test.where(patient_id: params[:patient_id])
    if @tests
      render json: @tests
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end

  def find_by_test_id
    @test = Test.find(params[:test_id])
    if @test
      render json: @test
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end

  def nurse_make_test_finished
    @test = Test.find(params[:test_id])
    if @test.update(test_status: "finished", report_date: params[:report_date], report_url: params[:report_url])
      render json: @test
    else
      render json: @test.errors, status: :unprocessable_entity
    end
  end

  def test_by_patient_id
    @tests = Test.where(patient_id: params[:patient_id]).where(test_status: "finished")
    if @tests
      render json: @tests
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end

  def last_test_by_patient_id
    @test = Test.where(patient_id: params[:patient_id]).order(test_date: :desc).first
    if @test
      render json: @test
    else
      render json: { error: "Test not found" }, status: :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_params
      params.require(:test).permit(:test_type, :test_status, :test_date, :test_place, :report_date, :report_url, :nurse_id, :patient_id, :doctor_id, :test_notes)
    end
end
