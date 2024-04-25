require "test_helper"

class DoctorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doctor = doctors(:one)
  end

  test "should get index" do
    get doctors_url, as: :json
    assert_response :success
  end

  test "should create doctor" do
    assert_difference("Doctor.count") do
      post doctors_url, params: { doctor: { Doctor_id: @doctor.Doctor_id, name: @doctor.name, password_digest: @doctor.password_digest, username: @doctor.username } }, as: :json
    end

    assert_response :created
  end

  test "should show doctor" do
    get doctor_url(@doctor), as: :json
    assert_response :success
  end

  test "should update doctor" do
    patch doctor_url(@doctor), params: { doctor: { Doctor_id: @doctor.Doctor_id, name: @doctor.name, password_digest: @doctor.password_digest, username: @doctor.username } }, as: :json
    assert_response :success
  end

  test "should destroy doctor" do
    assert_difference("Doctor.count", -1) do
      delete doctor_url(@doctor), as: :json
    end

    assert_response :no_content
  end
end
