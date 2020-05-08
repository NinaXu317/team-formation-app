module EnrollmentManager

    class Registrar

        def drop_course(student_id, course_id)
            Preference.where(student_id: student_id, course_id: course_id).delete_all
            Taking.where(student_id: student_id, course_id: course_id).delete_all
        end
    
    end
    
end