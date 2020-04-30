module GroupCreationManager

    #Class meant to hold all service functions for creating groups
    #in order to thin controller code
    class GroupMatcher
        
        #Returns an array of projects from given course
        def getProjects(course)
            projects = []
            course.groups.each do |group|
                if group.active
                    projects << group.id
                end
            end
            return projects
        end

        #returns an array of students from given course
        def getStudents(course)
            students = []
            course.students.each do |student| 
                students << student.id
            end
            return students
        end

        #Returns an array of preferences from given course
        def getPreferences(course)
            preferences = []
            course.preferences.each do |preference|
                preference_hash = {student_id: preference.student_id,
                                first: preference.first,
                                second: preference.second,
                                third: preference.third,
                                codingProficiency: preference.codingProficiency,
                                dreampartner: preference.dreampartner,
                                schedule: preference.schedule}
                preferences << preference_hash
            end
            return preferences
        end

        #Determines the desired algorithm from the params
        #and creates groups with that algorithm
        def determineAlgorithmAndMatch(course, params)
            students, projects = getStudentsAndProjects(course)
            preferences = getPreferences(course)

            algorithm = params[:algo]
            if algorithm == "random"
                matching_object = RandomMatching.new
                matching_object.initAndRandomMatch(students, projects)
            elsif algorithm == "project_only"
                matching_object = ProjectMatching.new
                matching_object.initAndProjectMatch(projects, preferences)
            elsif algorithm == "holistic"
                professor_preferences = getProfessorPreferences(params)
                matching_object = HolisticMatching.new
                matching_object.initAndHolisticMatch(projects, preferences, professor_preferences)
            end
            assignGroups(matching_object.matched_groups)
        end

        #Returns a hash of professor preferences from given params
        def getProfessorPreferences(params)
            return ({projectWeight: params[:projectWeight].to_i,
                codingWeight: params[:codingWeight].to_i,
                partnerWeight: params[:partnerWeight].to_i,
                scheduleWeight: params[:scheduleWeight].to_i
            })
        end

        #Returns the students and projects array in one function call
        def getStudentsAndProjects(course) 
            students = getStudents(course)
            projects = getProjects(course)
            return students, projects
        end

        #Updates database to assign students to groups
        def assignGroups(groups_hash)
            groups_hash.each do |group, students|
                puts "Group: " + group.inspect
                puts "Students: " + students.inspect
                students.each do |student|
                    group_record = Group.find(group)
                    puts "Student: " + student.inspect
                    puts "Group course id: " + group_record.course_id.inspect
                    groupAssigment = Taking.find_by(student_id: student, course_id: group_record.course.id)
                    groupAssigment.update(group_id: group_record.id)
                end
            end
        end
    end
end