class HolisticMatching < ProjectMatching
    # input @matched_groups as the result from our algorithm that uses project preferences
    # input @Preferences as an array of Hashes. Each hash is of the form {student_id,first(in int),second,third,codingProficiency, 
    # dreampartner(int),schedule},
    # Output: Hash of arrays, with {project_id: [student1,student2,student3]}

    def initAndHolisticMatch(projects, preferences, professor_preferences)
        initProjects(projects, preferences)
        add_professor_preferences(professor_preferences)
        holistic_algorithm()
    end


    def holistic_algorithm
        match()
        initial_team = @matched_groups
        result = initial_team
        if (result.keys.size==1) then
            return result
        end
        puts "result: " + result.inspect
        @preferences_hash = convertAH_toHH()
        #iterate swapping certain number of time
        highest_score = get_score(result)
        puts  "score before the holistic algorithm is",highest_score

        swap_history = []
        swap_history << initial_team
        i=0
        while i< @preferences.size do
            temp_formation= swap_member(result)
   
            if (duplicate(temp_formation, swap_history)) then
                i =i+1
                next
            end
            #temp_formation = the hash or arrays after a swap 
            swap_history << temp_formation
            puts "temp_formation: " + temp_formation.inspect
            temp_score = get_score(temp_formation)
            # if(temp_score<0) then next end
            # # puts temp_score
            if(temp_score > highest_score) then
                result = temp_formation
                highest_score= temp_score
            end
            i=i+1
        end
        puts "score after the holistic algorithm is",highest_score, result.inspect
        @matched_groups = result
    end


    #return true if the team has already existed in history
    # OPTIONAL TODO: could be implemented to optimize performance
    def duplicate(team, history)
        return false
    end

    #Returns nil if there is nobody on the team to avoid errors
    #following the rand function being called on 0, giving a decimal index
    def check_for_empty_teams(teams, team)
        if teams[team].size == 0
            return student1_index = nil
        else
            return student1_index = rand(teams[team].size)
        end
    end


    #team is a hash of arrays
    def swap_member(team)
        team1= team.keys.sample
        team2= team.keys.sample
        while(team2 == team1) do
            team2= team.keys.sample
        end
        student1_index = check_for_empty_teams(team, team1)
        # puts "nil check4: " + team[team1].inspect
        student2_index = check_for_empty_teams(team, team2)
        # puts "nil check5: " + student2_index.inspect
        if student1_index.nil?
            temp = nil
        else
            temp = team[team1][student1_index]
        end
        # puts "nil check6: " + temp.inspect

        # puts "team check: " + team.inspect
        if student2_index.nil?
            team[team1] = []
        else
            if student1_index.nil?
                team[team1] << team[team2][student2_index]
            else
                team[team1][student1_index]= team[team2][student2_index]
            end
        end
        # puts "nil check7: " + team.inspect
        if temp.nil?
            team[team2] = []
        else
            if student2_index.nil?
                team[team2] << temp
            else
                team[team2][student2_index]= temp
            end
        end
        # puts "nil check8: " + team.inspect
        # puts"after swap is", team.inspect
        return team
    end

    # This will convert an array of hash of preferences into a hash of hash, 
    # In the form of {id: {:first, :second, :third }}
    def convertAH_toHH()
        h = {}
        @preferences.each do |x|
            key= x[:student_id]
            value = x
            h[key]=value
        end
        return h 
    end


    #input a hash of arrays with the current formation
    #return the lowest team score 
    def get_score(formation)
        lowest_score = Float::MAX
        formation.each do |proj_id, teamArr|
            #TODO  multiply each score by the weight from the professor
            score = @professor_preferences[:scheduleWeight]*get_schedule_score(teamArr) + 
            @professor_preferences[:codingWeight]*get_coding_score(teamArr) + 
            @professor_preferences[:partnerWeight]*get_partner_score(teamArr) + 
            @professor_preferences[:projectWeight]*get_project_score(teamArr,proj_id)
            # puts "each score is",score
            if (score < lowest_score) then
                lowest_score = score
            end
        end
        return lowest_score
    end

    







    #preference schedule has the form of "{\"mondayD\":\"0\",\"mondayN\":\"1\",\"tuesdayD\":\"1\",\"tuesdayN\":\"0\",\"wednesdayD\":\"0\",\"wednesdayN\":\"0\",\"thursdayD\":\"1\",\"thursdayN\":\"0\",\"fridayD\":\"0\"
    #,\"fridayN\":\"1\",\"saturdayD\":\"0\",\"saturdayN\":\"0\",\"sundayD\":\"0\",\"sundayN\":\"0\"}"


    def get_schedule_score(teamArr)
        #initalize a team counter hash
        team_calendar = {}
        team_calendar["mondayD"]=0
        team_calendar["mondayN"]=0
        team_calendar["tuesdayD"]=0
        team_calendar["tuesdayN"]=0
        team_calendar["wednesdayD"]=0
        team_calendar["wednesdayN"]=0
        team_calendar["thursdayD"]=0
        team_calendar["thursdayN"]=0
        team_calendar["fridayD"]=0
        team_calendar["fridayN"]=0
        team_calendar["saturdayD"]=0
        team_calendar["saturdayN"]=0
        team_calendar["sundayD"]=0
        team_calendar["sundayN"]=0

        teamArr.each do |student|
            schedule = @preferences_hash[student][:schedule]
            # schedule = schedule_string[student]
            schedule.delete!("\n")
            schedule_J = JSON.parse(schedule)
            schedule_J.each do |key,value| 
                team_calendar[key]+= value.to_i
            end
        end

        counter=0
        team_calendar.each do |time,team_c|
            if(team_c/teamArr.size == 1) then
                counter +=1
            end
        end

        if(counter<1) then
            return -1
        else
            return (Math.log(counter.to_f/14+0.5)-Math.log(0.5))/Math.log(2+counter.to_f/14)
        end
    end


    #assuming the score range between 1 and 5 
    #the result would close to 0 if similar, close to 1 if different
    def get_coding_score(teamArr)
        response = []
        teamArr.each do |x|
            response << @preferences_hash[x][:codingProficiency]
        end
        response.uniq()
        
        return (response.size/5.0)
        #[0.2 - 1.0]
    end

    def get_partner_score(teamArr)
        counter =0
        teamArr.each do |x|
            if(@preferences_hash[x][:dreampartner].nil?) then
                next
            end

            if (teamArr.include? @preferences_hash[x][:dreampartner]) then
                counter = counter + 1
            end
        end
        return counter.to_f/teamArr.size
        #[0-1]
    end

    # first choice gets to earn 4 points, 2nd gets to earn 2 points, third earn 1 points, no option gets  -1
    def get_project_score(teamArr,proj_id)
        counter=0
        teamArr.each do |x|
            if (proj_id == @preferences_hash[x][:first]) then
                counter = counter+4
            elsif (proj_id == @preferences_hash[x][:second]) then
                counter = counter+2
            elsif (proj_id == @preferences_hash[x][:third]) then
                counter = counter+1
            else 
                counter = counter-1
            end
        end
        return counter.to_f/teamArr.size 
        #range of [-1, 4]
    end
end