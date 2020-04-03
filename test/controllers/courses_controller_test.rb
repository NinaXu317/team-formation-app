require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest

  include SessionsHelper
  
  setup do
    @course = courses(:one)
    @user = professors(:admin)
  end

  # test "should get new" do
    
    # professor_http_code = post professors_path, params:  {professor: {firstname:@user.firstname,
    #                               lastname: @user.lastname,
    #                               email: @user.email,
    #                               password: "123456",
    #                               password_confirmation: "123456"}}
    # puts "Professor post http code: " + professor_http_code.to_s
    # login_http_code = post login_path, params: {email: @user.email,
    #     password: "123456",
    #     type: {field: "professor"}}
    # puts "Login post http code: " + login_http_code.to_s
    # get new_course_url
    # assert_response :success
  # end

  # test "should get index" do
  #   get courses_url
  #   assert_response :success
  # end

  # test "should create course" do
  #   assert_difference('Course.count') do
  #     post courses_url, params: { course: { name: @course.name, pin: @course.pin, professor_id: @course.professor_id } }
  #   end

  #   assert_redirected_to course_url(Course.last)
  # end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_course_url(@course)
  #   puts @course.inspect + "\n\n"
  #   assert_response :success
  # end

  # test "should update course" do
  #   patch course_url(@course), params: { course: { name: @course.name, pin: @course.pin, professor_id: @course.professor_id } }
  #   assert_redirected_to course_url(@course)
  # end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
