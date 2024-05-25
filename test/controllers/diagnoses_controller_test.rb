require "test_helper"

class DiagnosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diagnosis = diagnoses(:one)
  end

  test "should get index" do
    get diagnoses_url, as: :json
    assert_response :success
  end

  test "should create diagnosis" do
    assert_difference("Diagnosis.count") do
      post diagnoses_url, params: { diagnosis: { category: @diagnosis.category, diagnose_id: @diagnosis.diagnose_id, doctor_id: @diagnosis.doctor_id, doctor_notes: @diagnosis.doctor_notes, patient_id: @diagnosis.patient_id } }, as: :json
    end

    assert_response :created
  end

  test "should show diagnosis" do
    get diagnosis_url(@diagnosis), as: :json
    assert_response :success
  end

  test "should update diagnosis" do
    patch diagnosis_url(@diagnosis), params: { diagnosis: { category: @diagnosis.category, diagnose_id: @diagnosis.diagnose_id, doctor_id: @diagnosis.doctor_id, doctor_notes: @diagnosis.doctor_notes, patient_id: @diagnosis.patient_id } }, as: :json
    assert_response :success
  end

  test "should destroy diagnosis" do
    assert_difference("Diagnosis.count", -1) do
      delete diagnosis_url(@diagnosis), as: :json
    end

    assert_response :no_content
  end
end
