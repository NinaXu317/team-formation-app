class PreferencesController < ApplicationController
    def index
        @preferences = Preference.all
        redirect_to :root
    end
    
    def new 
        @preference = Preference.new
        @course = Course.find(params[:course])
        @projects = @course.groups.all
        @students = @course.students.all
    end

 
    def create
        course = Course.find(params[:preference][:course_id])
        @preference = Preference.new(preference_params) 
        Preference.where(student_id: params[:preference][:student_id], course_id: params[:preference][:course_id]).destroy_all
        if (@preference.save)
          flash[:success] = "Thanks for submitting your preference!"
          redirect_to @preference.course
        else
          flash[:alert] = @preference.errors
          redirect_to new_preference_path(course: course)
        end
    end
    
    private
    
    def preference_params
          params.require(:preference).permit(:first, :second, :third, :codingProficiency, 
                                            :dreampartner, :schedule, :student_id, :course_id)
    end
end
    


    

