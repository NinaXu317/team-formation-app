class SimpleMatching

    def matched_groups
        @matched_groups
    end

    def add_students(students)
        @students = students
    end

    def add_projects(projects)
        @projects = projects
    end

    def init(students, projects)
        add_students(students)
        add_projects(projects)
    end

    def initAndMatch(students, projects)
        init(students,projects)
        randomMatching()
    end

    def randomMatching()
        result = {}
        @projects.each do |x|
            result[x]=[]
        end
        group_size = (@students.size/ @projects.size)
        temp_project_index = 0
    
        @students.each do |x|
    
            while(result[@projects[temp_project_index]].size>group_size)
                temp_project_index = (temp_project_index+1) % @projects.size
            end
            result[@projects[temp_project_index]].append(x)
            temp_project_index = (temp_project_index+1) % @projects.size
            
        end
    
        @matched_groups = result
    end
end
