require 'test_helper'

class ProfessorCreateCourseTest < ActionDispatch::IntegrationTest
    include SessionsHelper

    setup do
        @user = professors(:one)
        @course = courses(:FakeCourse3)
    end

    test "should display professor" do
        get professor_url(@user)
        assert_response :success
    end

    test "should get new" do
        log_in_as(@user)
        get new_course_url
        assert_response :success
    end

    # test "create new course" do
    #     assert_difference("Course.count") do
    #         post courses_url, params: { course: { name: "FakeCourse3", pin: "1111", professor_id: @user.id } }
    #     end
    # end

end