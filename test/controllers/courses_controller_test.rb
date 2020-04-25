require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest

  include SessionsHelper
  
  
  setup do
    @course = courses(:one)
    @user = professors(:admin)
  end

  test "should get new" do
    log_in_as(@user)
    get new_course_url
    assert_response :success
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { name: "Fakology", pin: "1122", professor_id: 1 } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { name: @course.name, pin: @course.pin, professor_id: @course.professor_id } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to @course.professor
  end
end
