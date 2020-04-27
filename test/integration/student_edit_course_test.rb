require 'test_helper'

class StudentEditCourseTest < ActionDispatch::IntegrationTest

    setup do
        @student = students(:derek)
        @course = courses(:SearchCourse)
    end

    test "student can add course" do 
        log_in_as(@student)
        get student_path(@student)
        assert_response :success
        
        assert_difference('@student.courses.size') do
            post search_course_student_path(@student), params: {pin: @course.pin}
        end
        assert_response :redirect
        follow_redirect!
        assert_response :success
    end

end