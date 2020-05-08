module EnrollmentManager

    #Meant to hold all functions for student's course management
    class Registrar

        #Drops a student from a course and destorys their preferences for that course
        def drop_course(student_id, course_id)
            Preference.where(student_id: student_id, course_id: course_id).delete_all
            Taking.where(student_id: student_id, course_id: course_id).delete_all
        end

        #If the pin is valid and they are not already enrolled, 
        #enrolls the student in course
        def enroll_in_course(student_id, pin)
            course = Course.where(pin: pin).take
            if course.nil?
                return "There is no course with that pin"
            end

            if Taking.where(student_id: student_id, course_id: course.id).size > 0
                return "You have already enrolled in this course"
            end

            Taking.create(student_id: student_id, course_id: course.id)
            return "Course added!"
        end
    
    end
    
end