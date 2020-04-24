class ErrorService

    def no_students()
        {type: "no students", message: "There needs to be at least 1 student"}
    end

    def no_groups()
         {type: "no groups", message: "There needs to be at least 1 group"}
    end

    def more_projects_than_students(difference) 
        {type: "more projects than students", message: "There are currently 
        more available projects than students, please make sure you have enough 
        students to be placed into all available projects or put at least #{difference} on hold."}
    end

    def missing_preferences(students)
        {type: "missing preferences", message: "These students need to add their preferences: #{students}"}
    end

    def invalid_preferences(students)
        {type: "invalid preferences", message: "These students must redo their preferences: #{students}"}
    end

    def to_string(errors)
        errors_string = ""
        errors.each do |error_hash|
            errors_string += "\n" + error_hash[:type] + ": " + error_hash[:message] + "\n"
        end
        return errors_string
    end

    def getStudentsWithoutPreference(course)
        students_without_preference = []
        course.students.each do |student|
          if student.preferences.where(course_id: course.id).size == 0
            students_without_preference << student.full_name
          end
        end
        return students_without_preference
    end

    def validatePreferences(preferences)
        students_with_invalid_preferences = []
        preferences.each do |preference|
            if !preference.choicesArePresent
                students_with_invalid_preferences << Student.find(preference.student_id).full_name
            end
        end
        return students_with_invalid_preferences
    end

    def handle_group_creation_errors(course)
        errors = []
        if course.students.size == 0
            errors << no_students()
        end
      
        if course.groups.size == 0
            errors << no_groups()
        end
      
        project_students_difference = course.groups.size - course.students.size
        if project_students_difference > 0
            errors << more_projects_than_students(project_students_difference)
        end
    
        if course.preferences.size < course.students.size
        students_without_preference = getStudentsWithoutPreference(course)
            errors << missing_preferences(students_without_preference)
        end
    
        invalidStudents = validatePreferences(course.preferences)
        if !invalidStudents.empty?
            errors << invalid_preferences(invalidStudents)
        end
        return errors
    end

end