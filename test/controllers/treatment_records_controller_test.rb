require "test_helper"

class TreatmentRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_record = treatment_records(:one)
  end

  test "should get index" do
    get treatment_records_url, as: :json
    assert_response :success
  end

  test "should create treatment_record" do
    assert_difference("TreatmentRecord.count") do
      post treatment_records_url, params: { treatment_record: { last_treatment_date: @treatment_record.last_treatment_date, nurse_id: @treatment_record.nurse_id, patient_id: @treatment_record.patient_id, treatment_date: @treatment_record.treatment_date, treatment_id: @treatment_record.treatment_id, treatment_notes: @treatment_record.treatment_notes, treatment_record_id: @treatment_record.treatment_record_id, treatment_status: @treatment_record.treatment_status } }, as: :json
    end

    assert_response :created
  end

  test "should show treatment_record" do
    get treatment_record_url(@treatment_record), as: :json
    assert_response :success
  end

  test "should update treatment_record" do
    patch treatment_record_url(@treatment_record), params: { treatment_record: { last_treatment_date: @treatment_record.last_treatment_date, nurse_id: @treatment_record.nurse_id, patient_id: @treatment_record.patient_id, treatment_date: @treatment_record.treatment_date, treatment_id: @treatment_record.treatment_id, treatment_notes: @treatment_record.treatment_notes, treatment_record_id: @treatment_record.treatment_record_id, treatment_status: @treatment_record.treatment_status } }, as: :json
    assert_response :success
  end

  test "should destroy treatment_record" do
    assert_difference("TreatmentRecord.count", -1) do
      delete treatment_record_url(@treatment_record), as: :json
    end

    assert_response :no_content
  end
end
