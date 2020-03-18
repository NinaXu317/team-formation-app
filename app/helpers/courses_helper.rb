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

    def randomAlgo (proj, student)
        result = {}
        proj.each do |x|
            result[x]=[]
        end
        group_size = (student.size/ proj.size)
        temp_project_index = 0
    
        student.each do |x|
    
            while(result[proj[temp_project_index]].size>group_size)
                temp_project_index = (temp_project_index+1) % proj.size
            end
            result[proj[temp_project_index]].append(x)
            temp_project_index = (temp_project_index+1) % proj.size
            
        end
    
        return result
    
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
