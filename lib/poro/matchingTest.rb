require 'minitest/spec'
require 'minitest/autorun'
require_relative 'matching'

describe SimpleMatching do
    
    before do 
        #list of the project ids
        projects = [1,2,3]
        
        preferences = [{student_id:1,first:1,second:2,third:3},{student_id:2,first:2,second:1,third:3},
        {student_id:3,first:1,second:2,third:3},{student_id:4,first:1,second:2,third:3},
        {student_id:5,first:2,second:3,third:1},{student_id:6,first:1,second:2,third:3},
        {student_id:7,first:1,second:2,third:3},{student_id:8,first:1,second:2,third:3}]
    
        @matcher = SimpleMatching.new()
        @matcher.initProjects(projects, preferences)
    end

    # it "can be initialized" do
    #   @matcher.
    # end
  
    it "can successfully initialize parameters"do
        # @matcher.get_preference.wont_be_nil
        @matcher.get_preference.wont_be_empty
        @matcher.get_projects.wont_be_empty
        @matcher.get_preference[0][:first].must_equal(1)
    end

    it "can match student with 3 projects preferences" do
        result = @matcher.matching_with_projects()
        result.size.must_equal(3)
        result.each do |projectid, studentA|
            studentA.wont_be_empty
        end
    end

        

end