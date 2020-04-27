require 'minitest/spec'
require 'minitest/autorun'
require_relative 'Matching'
require_relative 'ProjectMatching'
require_relative 'HolisticMatching'
# require_relative 'ProjectMatching'

describe HolisticMatching do
    
    before do 
        #list of the project ids
        projects = [1,2,3]
        
        
        #codingProficiency 1 to 5
        #TODO Professor's weight not yet Assigned(ez fix once we have that page)
        preferences = [{student_id:1,first:1,second:2,third:3,codingProficiency:3,dreampartner:3,schedule:"[{\"weekday\":\"Sunday\",\"start\":\"09:00:00\",\"end\":\"11:30:00\"},{\"weekday\":\"Tuesday\",\"start\":\"09:00:00\",\"end\":\"11:30:00\"},{\"weekday\":\"Wednesday\",\"start\":\"09:30:00\",\"end\":\"10:30:00\"},{\"weekday\":\"Wednesday\",\"start\":\"11:00:00\",\"end\":\"12:00:00\"}]"},
        {student_id:2,first:2,second:1,third:3,codingProficiency:2,dreampartner:4,schedule:"[{\"weekday\":\"Monday\",\"start\":\"09:00:00\",\"end\":\"12:00:00\"},{\"weekday\":\"Friday\",\"start\":\"09:00:00\",\"end\":\"14:30:00\"},{\"weekday\":\"Wednesday\",\"start\":\"09:30:00\",\"end\":\"14:30:00\"}]"},
        {student_id:3,first:1,second:2,third:3,codingProficiency:3,dreampartner:2,schedule:"[{\"weekday\":\"Saturday\",\"start\":\"09:00:00\",\"end\":\"14:00:00\"},{\"weekday\":\"Wednesday\",\"start\":\"09:00:00\",\"end\":\"15:00:00\"},{\"weekday\":\"Monday\",\"start\":\"09:00:00\",\"end\":\"14:30:00\"},{\"weekday\":\"Tuesday\",\"start\":\"09:00:00\",\"end\":\"14:30:00\"},{\"weekday\":\"Sunday\",\"start\":\"09:00:00\",\"end\":\"14:00:00\"},{\"weekday\":\"Thursday\",\"start\":\"09:30:00\",\"end\":\"14:00:00\"},{\"weekday\":\"Friday\",\"start\":\"09:00:00\",\"end\":\"14:30:00\"}]"},
        {student_id:4,first:1,second:2,third:3,codingProficiency:4,dreampartner:1,schedule:"[{\"weekday\":\"Sunday\",\"start\":\"09:00:00\",\"end\":\"13:00:00\"},{\"weekday\":\"Monday\",\"start\":\"10:30:00\",\"end\":\"14:30:00\"},{\"weekday\":\"Tuesday\",\"start\":\"11:00:00\",\"end\":\"15:00:00\"},{\"weekday\":\"Tuesday\",\"start\":\"08:30:00\",\"end\":\"11:00:00\"},{\"weekday\":\"Wednesday\",\"start\":\"08:00:00\",\"end\":\"14:00:00\"},{\"weekday\":\"Thursday\",\"start\":\"08:30:00\",\"end\":\"13:00:00\"},{\"weekday\":\"Friday\",\"start\":\"10:00:00\",\"end\":\"14:30:00\"},{\"weekday\":\"Saturday\",\"start\":\"08:30:00\",\"end\":\"11:30:00\"}]"},
        {student_id:5,first:2,second:3,third:1,codingProficiency:5,dreampartner:2,schedule:"[{\"weekday\":\"Sunday\",\"start\":\"08:00:00\",\"end\":\"10:30:00\"},{\"weekday\":\"Monday\",\"start\":\"11:00:00\",\"end\":\"13:30:00\"},{\"weekday\":\"Sunday\",\"start\":\"13:30:00\",\"end\":\"15:00:00\"},{\"weekday\":\"Tuesday\",\"start\":\"16:00:00\",\"end\":\"18:30:00\"},{\"weekday\":\"Wednesday\",\"start\":\"15:00:00\",\"end\":\"17:30:00\"},{\"weekday\":\"Friday\",\"start\":\"09:30:00\",\"end\":\"13:00:00\"},{\"weekday\":\"Wednesday\",\"start\":\"10:00:00\",\"end\":\"13:30:00\"},{\"weekday\":\"Saturday\",\"start\":\"16:30:00\",\"end\":\"19:00:00\"}]"},
        {student_id:6,first:1,second:2,third:3,codingProficiency:1,dreampartner:2,schedule:"[{\"weekday\":\"Tuesday\",\"start\":\"17:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Sunday\",\"start\":\"16:30:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Friday\",\"start\":\"17:30:00\",\"end\":\"18:00:00\"},{\"weekday\":\"Friday\",\"start\":\"17:00:00\",\"end\":\"17:30:00\"},{\"weekday\":\"Friday\",\"start\":\"18:00:00\",\"end\":\"18:30:00\"},{\"weekday\":\"Saturday\",\"start\":\"17:00:00\",\"end\":\"17:30:00\"},{\"weekday\":\"Saturday\",\"start\":\"17:30:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Thursday\",\"start\":\"17:00:00\",\"end\":\"19:00:00\"}]"},
        {student_id:7,first:1,second:2,third:3,codingProficiency:2,dreampartner:3,schedule:"[{\"weekday\":\"Sunday\",\"start\":\"17:30:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Tuesday\",\"start\":\"18:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Wednesday\",\"start\":\"08:00:00\",\"end\":\"13:00:00\"},{\"weekday\":\"Tuesday\",\"start\":\"13:30:00\",\"end\":\"18:00:00\"},{\"weekday\":\"Thursday\",\"start\":\"15:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Friday\",\"start\":\"08:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Saturday\",\"start\":\"15:30:00\",\"end\":\"18:00:00\"}]"},
        {student_id:8,first:1,second:2,third:3,codingProficiency:3,dreampartner:4,schedule:"[{\"weekday\":\"Sunday\",\"start\":\"16:30:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Thursday\",\"start\":\"17:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Saturday\",\"start\":\"17:00:00\",\"end\":\"19:00:00\"},{\"weekday\":\"Tuesday\",\"start\":\"13:00:00\",\"end\":\"16:00:00\"},{\"weekday\":\"Saturday\",\"start\":\"13:00:00\",\"end\":\"16:30:00\"},{\"weekday\":\"Friday\",\"start\":\"12:30:00\",\"end\":\"17:00:00\"},{\"weekday\":\"Sunday\",\"start\":\"12:00:00\",\"end\":\"14:00:00\"},{\"weekday\":\"Wednesday\",\"start\":\"14:00:00\",\"end\":\"18:00:00\"}]"}]

        @matcher = HolisticMatching.new()
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

    it "can successfully initialize parameters"do
        # @matcher.get_preference.wont_be_nil
        # @matcher.holistic_algorithm.wont_be_empty
    end




    it "can parse Team schedule"do
        result = @matcher.holistic_algorithm
        puts result.inspect
        result.wont_be_empty

        # puts "the common available slots for this team is"
        
        # team_calendar["Tuesday"][3].must_equal 1
        # schedule_J[0]["weekday"].must_equal("Sunday")


    end
end

