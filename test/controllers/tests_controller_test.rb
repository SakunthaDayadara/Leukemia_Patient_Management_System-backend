require "test_helper"

class TestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test = tests(:one)
  end

  test "should get index" do
    get tests_url, as: :json
    assert_response :success
  end

  test "should create test" do
    assert_difference("Test.count") do
      post tests_url, params: { test: { doctor_id: @test.doctor_id, nurse_id: @test.nurse_id, patient_id: @test.patient_id, report_date: @test.report_date, report_url: @test.report_url, test_date: @test.test_date, test_id: @test.test_id, test_place: @test.test_place, test_status: @test.test_status, test_type: @test.test_type } }, as: :json
    end

    assert_response :created
  end

  test "should show test" do
    get test_url(@test), as: :json
    assert_response :success
  end

  test "should update test" do
    patch test_url(@test), params: { test: { doctor_id: @test.doctor_id, nurse_id: @test.nurse_id, patient_id: @test.patient_id, report_date: @test.report_date, report_url: @test.report_url, test_date: @test.test_date, test_id: @test.test_id, test_place: @test.test_place, test_status: @test.test_status, test_type: @test.test_type } }, as: :json
    assert_response :success
  end

  test "should destroy test" do
    assert_difference("Test.count", -1) do
      delete test_url(@test), as: :json
    end

    assert_response :no_content
  end
end
