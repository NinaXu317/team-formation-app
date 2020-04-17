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

    def add_preferences(preferences)
        @preferences = preferences
    end

    def initRandom(students, projects)
        add_students(students)
        add_projects(projects)
    end

    def initAndRandomMatch(students, projects)
        initRandom(students,projects)
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
        puts "\n\n\n\n" + result.inspect + "\n\n\n\n"
        @matched_groups = result
    end

    def initProjects(projects, preferences)
        add_projects(projects)
        add_preferences(preferences)
    end

    def initAndProjectMatch(projects, preferences)
        initProjects(projects, preferences)
        matching_with_projects()
    end


    def get_preference
        return @preferences
    end

    def get_projects
        return @projects
    end

    # input @projects as an array of Projects IDs in INT
    # input @Preferences as an array of Hashes. Each hash is of the form {student_id,first(in int),second,third,codingProficiency},
    # For this algorithm, we are only considering the parameters of the first,second, and third options
    # Output: Hash of arrays, with {project_id: [student1,student2,student3]}
    def matching_with_projects()
        grousizemin=0
        groupsizemax=0
        groupsizefloat= @preferences.length.to_f/@projects.length
        if groupsizefloat.floor == groupsizefloat then
            groupsizemax= groupsizefloat
            grousizemin= groupsizefloat
        else
            groupsizemax= groupsizefloat.ceil
            grousizemin= groupsizefloat.floor
        end

        result ={}
        # project_status = {}
        @projects.each do |x|
            result[x]=[]
        end

        #(1)populate the result hash by assigning students's first choice
        @preferences.each do |x|
            temp_project_choice = x[:first]
            # puts result
            # puts temp_project_choice.class
            result[temp_project_choice] << x[:student_id]
        end

        j=0
        while j<@projects.length do
            #(2) Find the most popular array, and move out those's whos second choice is a project that is incomplete. 
            
            mostpopular_project= find_mostpopular_project(result)
            if result[mostpopular_project].length > groupsizemax then
                i=result[mostpopular_project].length-1
                while(result[mostpopular_project].length>groupsizemax && i>=0)
                #move students ID from this popular array to other array that are incomplete 
                # result[mostpopular_project].each do |student_id|
                #     if    
                # end
                unlucky_student= result[mostpopular_project][i]
                second_choice= @preferences.find {|project| project['student_id']= unlucky_student} [:second]
                if(result[second_choice].length < groupsizemax) then
                    result[mostpopular_project].delete(unlucky_student)
                    result[second_choice] << unlucky_student
                    # if result[second_choice].length == groupsizemax then
                    #     project_status[second_choice]= true
                    # end
                end
                i=i-1
                end
            #    project_status[mostpopular_project]== true
            end



            #(3) Find the most popular array, and move out those's whos third choice is a project that is incomplete. 
            if result[mostpopular_project].length > groupsizemax then
                i=result[mostpopular_project].length-1
            while(result[mostpopular_project].length>groupsizemax && i>=0)
                #move students ID from this popular array to other array that are incomplete 
                # result[mostpopular_project].each do |student_id|
                #     if    
                # end
                unlucky_student= result[mostpopular_project][i]
                second_choice= @preferences.find {|project| project['student_id']= unlucky_student} [:third]
                if(result[second_choice].length < groupsizemax) then
                    result[mostpopular_project].delete(unlucky_student)
                    result[second_choice] << unlucky_student
                    # if result[second_choice].length == groupsizemax then
                    #     project_status[second_choice]= true
                    # end
                end
                i=i-1
                end
            #    project_status[mostpopular_project]== true
            end
            
            #(4) If the array is still overpopulated, use random algo to move students out
            while result[mostpopular_project].length > groupsizemax 

                poor_student = result[mostpopular_project].delete(result[mostpopular_project].sample)

                result.find{|key,value| value.length<grousizemin} << poor_student
                
            end
        
        j=j+1
        end
    @matched_groups = result
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


    # input @matched_groups as the result from our algorithm that uses project preferences
    # input @Preferences as an array of Hashes. Each hash is of the form {student_id,first(in int),second,third,codingProficiency, 
    # dreampartner(int),schedule},
    # Output: Hash of arrays, with {project_id: [student1,student2,student3]}

    def holistic_algorithm
        matching_with_projects()
        initial_team = @matched_groups
        result = initial_team
        #iterate swapping certain number of time
        highest_score = get_score(result)
        i=0
        until i> @preferences.size/2
            #TODO SWAP
            #temp_formation = the hash or arrays after a swap 
            temp_score = get_score(temp_formation)
            if(temp_score > highest_score) then
                result = temp_formation
                highest_score= temp_score
            end
            i=i+1
        end

        @matched_groups = result
    end

    #input a hash of arrays with the current formation
    def get_score(formation)
        lowest_score = Float.MAX
        formation.each do |proj_id, studentArr|
            #TODO  multiply each score by the weight from the professor
            score = get_schedule_score(studentArr) + get_coding_score(studentArr) 
            + get_partner_score(studentArr) + get_project_score(studentArr)
            if (score < lowest_score) then
                lowest_score = score
            end
        end
        return lowest_score
    end

    
    #studentARR= form of [student1id,student2id,student3id]
    def get_schedule_score(studentArr)
        #TODO
    end

    #assuming the score range between 1 and 5 
    #the result would close to 0 if similar, close to 1 if different
    def get_coding_score(studentArr)

        codingProficiency
        retun (1)
    end

    def get_partner_score(studentArr)
    end

    def get_project_score(studentArr)
    end


end
