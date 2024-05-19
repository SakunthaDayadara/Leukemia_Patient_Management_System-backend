require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get appointments_url, as: :json
    assert_response :success
  end

  test "should create appointment" do
    assert_difference("Appointment.count") do
      post appointments_url, params: { appointment: { appointment_date: @appointment.appointment_date, appointment_status: @appointment.appointment_status, bmt_date: @appointment.bmt_date, bmt_report: @appointment.bmt_report, bp_report: @appointment.bp_report, bp_status: @appointment.bp_status, fbc_report: @appointment.fbc_report, fbc_status: @appointment.fbc_status, nurse_id: @appointment.nurse_id, patient_id: @appointment.patient_id } }, as: :json
    end

    assert_response :created
  end

  test "should show appointment" do
    get appointment_url(@appointment), as: :json
    assert_response :success
  end

  test "should update appointment" do
    patch appointment_url(@appointment), params: { appointment: { appointment_date: @appointment.appointment_date, appointment_status: @appointment.appointment_status, bmt_date: @appointment.bmt_date, bmt_report: @appointment.bmt_report, bp_report: @appointment.bp_report, bp_status: @appointment.bp_status, fbc_report: @appointment.fbc_report, fbc_status: @appointment.fbc_status, nurse_id: @appointment.nurse_id, patient_id: @appointment.patient_id } }, as: :json
    assert_response :success
  end

  test "should destroy appointment" do
    assert_difference("Appointment.count", -1) do
      delete appointment_url(@appointment), as: :json
    end

    assert_response :no_content
  end
end
