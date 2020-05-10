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

    def get_professor_id(course)
      professor = course.professor
      if !professor.nil?
        professor_id = professor.id
      else
        professor_id = nil
      end
      return professor_id
    end

    def three_active_groups?(course)
      active_groups = 0
      @groups.each do |group|
        if group.active
          active_groups += 1
        end
      end

      if active_groups < 3
        return false
      end

      return true
    end

    def button_disabled?(course)
      return !three_active_groups?(course) || course.voting
    end

    def get_message(course)
      if three_active_groups?(course)
        return ""
      end
      return "Less than 3 active projects"
    end

end
