#list of the project ids
proj = [1,2,3,4,5]
    
p_preference = {student_id:[1,2,3], student_id1: [3,4,2]}
#students with student ids
student = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].shuffle


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