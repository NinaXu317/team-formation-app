module CoursesHelper

    def showStudents(students)
        student_string = ""
        students.each do |student|
            student_string += student.firstname + " " + student.lastname + ", "
        end
        return student_string
    end

    def showGroups(groups)
        group_hash = {}
        groups.each do |group|
          group_string = ""
          group.students.each do |student|
            group_string += student.firstname + " " + student.lastname + ", "
          end
          group_hash[group.project_name] = group_string
        end
        return group_hash
    end
end
