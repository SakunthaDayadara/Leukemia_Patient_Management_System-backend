require "test_helper"

class TreatmentPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_plan = treatment_plans(:one)
  end

  test "should get index" do
    get treatment_plans_url, as: :json
    assert_response :success
  end

  test "should create treatment_plan" do
    assert_difference("TreatmentPlan.count") do
      post treatment_plans_url, params: { treatment_plan: { diagnose_id: @treatment_plan.diagnose_id, doctor_id: @treatment_plan.doctor_id, patient_id: @treatment_plan.patient_id, treatment_id: @treatment_plan.treatment_id, treatment_status: @treatment_plan.treatment_status, treatment_type: @treatment_plan.treatment_type } }, as: :json
    end

    assert_response :created
  end

  test "should show treatment_plan" do
    get treatment_plan_url(@treatment_plan), as: :json
    assert_response :success
  end

  test "should update treatment_plan" do
    patch treatment_plan_url(@treatment_plan), params: { treatment_plan: { diagnose_id: @treatment_plan.diagnose_id, doctor_id: @treatment_plan.doctor_id, patient_id: @treatment_plan.patient_id, treatment_id: @treatment_plan.treatment_id, treatment_status: @treatment_plan.treatment_status, treatment_type: @treatment_plan.treatment_type } }, as: :json
    assert_response :success
  end

  test "should destroy treatment_plan" do
    assert_difference("TreatmentPlan.count", -1) do
      delete treatment_plan_url(@treatment_plan), as: :json
    end

    assert_response :no_content
  end
end
