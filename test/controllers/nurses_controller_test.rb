require "test_helper"

class NursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nurse = nurses(:one)
  end

  test "should get index" do
    get nurses_url, as: :json
    assert_response :success
  end

  test "should create nurse" do
    assert_difference("Nurse.count") do
      post nurses_url, params: { nurse: { name: @nurse.name, nurse_id: @nurse.nurse_id, password_digest: @nurse.password_digest, username: @nurse.username, ward_id: @nurse.ward_id } }, as: :json
    end

    assert_response :created
  end

  test "should show nurse" do
    get nurse_url(@nurse), as: :json
    assert_response :success
  end

  test "should update nurse" do
    patch nurse_url(@nurse), params: { nurse: { name: @nurse.name, nurse_id: @nurse.nurse_id, password_digest: @nurse.password_digest, username: @nurse.username, ward_id: @nurse.ward_id } }, as: :json
    assert_response :success
  end

  test "should destroy nurse" do
    assert_difference("Nurse.count", -1) do
      delete nurse_url(@nurse), as: :json
    end

    assert_response :no_content
  end
end
