class MatchingTest_forAndy
    #list of the project ids
@projects = [1,2,3]
    
@preferences = [{"student_id"=>1,"first"=>'1',"second"=>'2',"third"=>'3'},{"student_id"=>2,"first"=>'2',"second"=>'1',"third"=>'3'},
{"student_id"=>3,"first"=>'1',"second"=>'2',"third"=>'3'},{"student_id"=>4,"first"=>'1',"second"=>'2',"third"=>'3'},
{"student_id"=>5,"first"=>'2',"second"=>'3',"third"=>'1'},{"student_id"=>6,"first"=>'1',"second"=>'2',"third"=>'3'},
{"student_id"=>7,"first"=>'1',"second"=>'2',"third"=>'3'},{"student_id"=>8,"first"=>'1',"second"=>'2',"third"=>'3'}]


    # input @projects as an array of Projects IDs 
    # input @Preferences as an array of Hashes. Each hash is of the form {student_id,first,second,third,codingProficiency},
    # Note: first,second,third are STRINGS, not int
    # For this algorithm, we are only considering the parameters of the first,second, and third options
    # Output: Hash of arrays, with {project_id: [student1,student2,student3]}
    def self.matching_with_projects()
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
            temp_project_choice = x['first'].to_i
            result[temp_project_choice].append(x['student_id'])
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
                second_choice= @preferences.find {|project| project['student_id']= unlucky_student} ['second'].to_i
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
                second_choice= @preferences.find {|project| project['student_id']= unlucky_student} ['third'].to_i
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
    return result
    end


    def self.find_mostpopular_project(result)
        most_popular_project= result.keys.sample
        result.each do |key,value|
            if value.length> result[most_popular_project].length then
                most_popular_project= key
            end
        end

        return most_popular_project
    end
    puts matching_with_projects().inspect

end