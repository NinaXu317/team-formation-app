require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @group = groups(:Kitties)
  end

  test "should get index" do
    get groups_url
    assert_response :success
  end

  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post groups_url, params: { group: { course_id: @group.course_id, project_name: @group.project_name, description: @group.description, position: 1 } }
    end

    assert_redirected_to course_url(@group.course)
  end

  test "should show group" do
    get group_url(@group)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :success
  end

  test "should update group" do
    patch group_url(@group), params: { group: { course_id: @group.course_id, project_name: @group.project_name } }
    assert_redirected_to group_url(@group)
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete group_url(@group)
    end
    assert_redirected_to groups_url
  end
end
