module TakingsHelper
    def projectName(student, course)
        pj_name = nil
        takings = student.takings
        if !takings.nil?
            courses = student.takings.where(course_id: course['id'])
            if !courses.nil?
                group = student.takings.where(course_id: course['id'])[0].group
                if !group.nil?
                    pj_name = group['project_name']
                end
            end
        end
        return pj_name
    end
end
