class ProjectMatching < Matching
    # def initProjects(projects, preferences)
    #     super
    # end
    
    # alias_method :parent_method, :initProjects
    # initProjects
    def initAndProjectMatch(projects, preferences)
        initProjects(projects, preferences)
        match()
    end


    #The main Method to start matching
    def match()
        @grousizemin=0
        @groupsizemax=0
        groupsizefloat= @preferences.length.to_f/@projects.length
        puts "There are this many projects:",@projects.length
        puts "There are this many students:",@preferences.length
        if groupsizefloat.floor == groupsizefloat then
            @groupsizemax= groupsizefloat
            @grousizemin= groupsizefloat
        else
            @groupsizemax= groupsizefloat.ceil
            @grousizemin= groupsizefloat.floor
        end

        result ={}
        # project_status = {}
        @projects.each do |x|
            result[x]=[]
        end

        #(1)populate the result hash by assigning students's first choice
        @preferences.each do |x|
            temp_project_choice = x[:first]
            result[temp_project_choice] << x[:student_id]
        end
        puts "Before moving people: " + result.inspect
        result = move_people(result)
        @matched_groups = result
    end

    #This will serve as a loop to iterate making sure all groups have the equal size
    def move_people(result)
        j=0
        while j<@projects.length do
            #(2) Find the most popular array, and move out those's whos second choice is a project that is incomplete. 
            mostpopular_project= find_mostpopular_project(result)
            if result[mostpopular_project].length > @groupsizemax then
                i=result[mostpopular_project].length-1
                while(result[mostpopular_project].length>@groupsizemax && i>=0)
                    #move students ID from this popular array to other array that are incomplete
                    unlucky_student= result[mostpopular_project][i]
                    second_choice= @preferences.find {|project| project['student_id']= unlucky_student} [:second]
                    if(result[second_choice].length < @groupsizemax) then
                        result[mostpopular_project].delete(unlucky_student)
                        result[second_choice] << unlucky_student
                    end
                    i=i-1
                end
            end

            #(3) Find the most popular array, and move out those's whos third choice is a project that is incomplete. 
            if result[mostpopular_project].length > @groupsizemax then
                i=result[mostpopular_project].length-1
                while(result[mostpopular_project].length>@groupsizemax && i>=0)
                    #move students ID from this popular array to other array that are incomplete 
                    unlucky_student= result[mostpopular_project][i]
                    #puts @preferences.inspect
                    second_choice= @preferences.find {|project| project['student_id']= unlucky_student} [:third]
                    if(result[second_choice].length < @groupsizemax) then
                        result[mostpopular_project].delete(unlucky_student)
                        result[second_choice] << unlucky_student
                    end
                    i=i-1
                end
            end
            
            #(4) If the array is still overpopulated, use random algo to move students out
            while result[mostpopular_project].length > @groupsizemax 
                puts @grousizemin.inspect
                poor_student = result[mostpopular_project].delete(result[mostpopular_project].sample)
                result[result.find{|key,value| key != mostpopular_project && value.length<=@grousizemin}[0]] << poor_student
            end
            j=j+1

            
        end

        #(5) check for group that has too little students
        # puts "current form:", result.inspect
        unfilled = result.find{|key,value| value.length<@grousizemin}
        # puts unfilled.inspect
        while(!unfilled.nil?) do
            most_p= find_mostpopular_project(result)
            poor_student = result[most_p].delete_at(result[most_p].size-1)
            result[unfilled[0]] << poor_student
            unfilled = result.find{|key,value| value.length<@grousizemin}
        end
        puts "current form after project Assign:", result.inspect
        return result
    end


    def find_mostpopular_project(result)
        most_popular_project= result.keys.sample
        result.each do |key,value|
            if value.length> result[most_popular_project].length then
                most_popular_project= key
            end
        end
        return most_popular_project
    end


end