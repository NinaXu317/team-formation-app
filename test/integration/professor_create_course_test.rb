require 'test_helper'

class ProfessorCreateCourseTest < ActionDispatch::IntegrationTest
    i_suck_and_my_tests_are_order_dependent!
    include SessionsHelper

    setup do
        @user = professors(:admin)
        @course = courses(:FakeCourse3)
    end

    test "display professor info" do
        get professor_url(@user)
        assert_response :success
        assert_template 'professors/show'
    end

    test "should get new" do
        log_in_as(@user)
        # assert_redirected_to @user
        # get new_course_url
        assert_response :redirect
    end

    # test "create new course" do
    #     assert_difference("Course.count") do
    #         post courses_url, params: { course: { name: "FakeCourse3", pin: "1111", professor_id: @user.id } }
    #     end
    #     assert_redirected_to course_url(Course.last)
    # end

    # test "should show course" do
    #     log_in_as(@user)
    #     get course_url(@course)
    #     assert_response :success
    # end

    test "is logged out?" do
        get logout_path
        assert_not is_logged_in?
        assert_redirected_to root_url
    end
end