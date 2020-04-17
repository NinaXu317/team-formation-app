class GroupCreationService
    def getProjects(course)
        projects = []
        course.groups.each do |group|
            projects << group.id
        end
        return projects
    end

    def getStudents(course)
        students = []
        course.students.each do |student| 
            students << student.id
        end
        return students
    end

    def getPreferences(course)
        preferences = []
        course.preferences.each do |preference|
            preference_hash = {student_id: preference.student_id,
                              first: preference.first,
                              second: preference.second,
                              third: preference.third,
                              codingProficiency: preference.codingProficiency}
            preferences << preference_hash
        end
        return preferences
    end

    def getStudentsAndProjects(course) 
        students = getStudents(course)
        projects = getProjects(course)
        return students, projects
    end

    def assignGroups(groups_hash)
        groups_hash.each do |group, students|
            students.each do |student|
                group_record = Group.find(group)
                groupAssigment = Taking.find_by(student_id: student, course_id: group_record.course.id)
                groupAssigment.update(group_id: group_record.id)
            end
        end
    end
end