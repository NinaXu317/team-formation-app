require 'test_helper'

class TakingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taking = takings(:one)
  end

  test "should get index" do
    get takings_url
    assert_response :success
  end

  test "should get new" do
    get new_taking_url
    assert_response :success
  end

  # test "should create taking" do
  #   assert_difference('Taking.count') do
  #     post takings_url, params: { taking: { course_id: @taking.course_id, group_id: @taking.group_id, student_id: @taking.student_id } }
  #   end

  #   assert_redirected_to taking_url(Taking.last)
  # end

  test "should show taking" do
    get taking_url(@taking)
    assert_response :success
  end

  test "should get edit" do
    get edit_taking_url(@taking)
    assert_response :success
  end

  # test "should update taking" do
  #   patch taking_url(@taking), params: { taking: { course_id: @taking.course_id, group_id: @taking.group_id, student_id: @taking.student_id } }
  #   assert_redirected_to taking_url(@taking)
  # end

  test "should destroy taking" do
    assert_difference('Taking.count', -1) do
      delete taking_url(@taking)
    end

    assert_redirected_to takings_url
  end
end
