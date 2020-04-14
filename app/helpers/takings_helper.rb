module TakingsHelper
    def group(student, course)
        takings = student.takings
        group = nil
        if !takings.nil?
            courses = student.takings.where(course_id: course['id'])
            if !courses.nil?
                group = student.takings.where(course_id: course['id'])[0].group
            end
        end
        return group
    end

end
