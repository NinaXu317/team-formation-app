class PreferencesController < ApplicationController
    def index
        @preferences = Preference.all
        redirect_to :root
    end
    
    def new
        @course = Course.find(params[:course])
        if @course.has_enough_projects
          @preference = Preference.new
          @projects = @course.groups.all
          @students = @course.students.all
        else
          flash[:alert] = "Can not create preferences until there are at least three active projects"
          redirect_to @course 
        end
    end

 
    def create
        course = Course.find(params[:preference][:course_id])
        @preference = Preference.new(preference_params) 
        Preference.where(student_id: params[:preference][:student_id], course_id: params[:preference][:course_id]).destroy_all
        if (@preference.save)
          flash[:success] = "Thanks for submitting your preference!"
          redirect_to @preference.course
        else
          puts @preference.errors.inspect
          puts @preference.errors.count.inspect
          flash[:alert] = @preference.errors
          flash[:count] = @preference.errors.count
          redirect_to new_preference_path(course: course)
        end
    end
    
    private
    
    def preference_params
          params.require(:preference).permit(:first, :second, :third, :codingProficiency, 
                                            :dreampartner, :schedule, :student_id, :course_id)
    end
end
    


    

