class RandomMatching < Matching

    def initAndRandomMatch(students, projects)
        initRandom(students,projects)
        match()
    end

    def match()
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
        puts "\n\n\n\n" + result.inspect + "\n\n\n\n"
        @matched_groups = result
    end
end