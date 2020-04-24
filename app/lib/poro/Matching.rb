require 'json'
require 'cmath'
# require_relative 'RandomMatching'
# require_relative 'ProjectMatching'
# require_relative 'HolisticMatching'
class Matching

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

    def add_professor_preferences(professor_preferences)
        @professor_preferences = professor_preferences
    end

    def initRandom(students, projects)
        add_students(students)
        add_projects(projects)
    end

    def initProjects(projects, preferences)
        add_projects(projects)
        add_preferences(preferences)
    end


    def get_preference
        return @preferences
    end

    def get_projects
        return @projects
    end


end
