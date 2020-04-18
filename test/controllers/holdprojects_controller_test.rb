require 'test_helper'

class HoldprojectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @holdproject = holdprojects(:one)
  end

  test "should get index" do
    get holdprojects_url
    assert_response :success
  end

  test "should get new" do
    get new_holdproject_url
    assert_response :success
  end

  test "should create holdproject" do
    assert_difference('Holdproject.count') do
      post holdprojects_url, params: { holdproject: { course_id: @holdproject.course_id, position: @holdproject.position, project_name: @holdproject.project_name } }
    end

    assert_redirected_to holdproject_url(Holdproject.last)
  end

  test "should show holdproject" do
    get holdproject_url(@holdproject)
    assert_response :success
  end

  test "should get edit" do
    get edit_holdproject_url(@holdproject)
    assert_response :success
  end

  test "should update holdproject" do
    patch holdproject_url(@holdproject), params: { holdproject: { course_id: @holdproject.course_id, position: @holdproject.position, project_name: @holdproject.project_name } }
    assert_redirected_to holdproject_url(@holdproject)
  end

  test "should destroy holdproject" do
    assert_difference('Holdproject.count', -1) do
      delete holdproject_url(@holdproject)
    end

    assert_redirected_to holdprojects_url
  end
end
