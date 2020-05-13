module GroupCreationManager

    #Class meant to hold error messages, detection, and generation functions for group generation
    class MatchingErrorGenerator < ErrorService

        #Returns error message for no students at time of group creation
        def no_students()
            new_error("no students", "There needs to be at least 1 student")
        end

        #Returns error message for no groups at time of group creation
        def no_groups()
            new_error("no groups", "There needs to be at least 1 group")
        end

        #Returns error message for there being more projects than students at time of group creation
        def more_projects_than_students(difference) 
            new_error("more projects than students", "There are currently 
            more available projects than students, please make sure you have enough 
            students to be placed into all available projects or put at least #{difference} on hold.")
        end

        #Returns error message for not all students having submitting their preferences at time of group creation
        def missing_preferences(students)
            new_error("missing preferences", "These students need to add their preferences: #{students}")
        end

        #Returns error message for there students having invalid preferences at time of group creation
        #Usually caused by a project idea being selected as first, second, or third choice and then deleted
        def invalid_preferences(students)
            new_error("invalid preferences", "These students must redo their preferences: #{students}")
        end

        #Returns an array of all students in given course who have not submitted their preferences
        def getStudentsWithoutPreference(course)
            students_without_preference = []
            course.students.each do |student|
                if student.preferences.where(course_id: course.id).size == 0
                    students_without_preference << student.full_name
                end
            end
            return students_without_preference
        end

        #Returns an array of all students with given preferences which contains project choices
        #which are no longer available
        def validatePreferences(preferences)
            students_with_invalid_preferences = []
            preferences.each do |preference|
                if !preference.choicesArePresent || !preference.choicesAreValid
                    students_with_invalid_preferences << Student.find(preference.student_id).full_name
                end
            end
            return students_with_invalid_preferences
        end

        #Returns an array of all group creation errors for given course and creation algorithm
        #Checks for following errors:
        #1. No Students
        #2. No Groups
        #3. More Projects than Students
        #4. Students Missing Preferences, if the algorithm takes preferences into account
        #5. Preferences are all valid
        def handle_group_creation_errors(course, algo)
            errors = []
            if course.students.size == 0
                errors << no_students()
            end
          
            if course.active_groups == 0
                errors << no_groups()
            end
          
            project_students_difference = course.active_groups - course.students.size
            if project_students_difference > 0
                errors << more_projects_than_students(project_students_difference)
            end
        
            if (algo != "random" && course.preferences.size < course.students.size)
                students_without_preference = getStudentsWithoutPreference(course)
                errors << missing_preferences(students_without_preference)
            end
        
            invalidStudents = validatePreferences(course.preferences)
            if (algo != "random" && !invalidStudents.empty?)
                errors << invalid_preferences(invalidStudents)
            end
            return errors
        end

    end
end