require "test_helper"

class BedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bed = beds(:one)
  end

  test "should get index" do
    get beds_url, as: :json
    assert_response :success
  end

  test "should create bed" do
    assert_difference("Bed.count") do
      post beds_url, params: { bed: { bed_id: @bed.bed_id, is_occupied: @bed.is_occupied, patient_id: @bed.patient_id, ward_num: @bed.ward_num } }, as: :json
    end

    assert_response :created
  end

  test "should show bed" do
    get bed_url(@bed), as: :json
    assert_response :success
  end

  test "should update bed" do
    patch bed_url(@bed), params: { bed: { bed_id: @bed.bed_id, is_occupied: @bed.is_occupied, patient_id: @bed.patient_id, ward_num: @bed.ward_num } }, as: :json
    assert_response :success
  end

  test "should destroy bed" do
    assert_difference("Bed.count", -1) do
      delete bed_url(@bed), as: :json
    end

    assert_response :no_content
  end
end
