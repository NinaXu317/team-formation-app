class PreferencesController < ApplicationController
    def index
        @preferences = Preference.all
    end
    
    def new 
        @preference = Preference.new
        @course = Course.find(params[:course])
        @projects = @course.groups.all
    end


    def create
        course = Course.find(params[:preference][:course_id])
        params[:preference][:first] = course.groups.find_by_project_name(params[:preference][:first]).id
        params[:preference][:second] = course.groups.find_by_project_name(params[:preference][:second]).id
        params[:preference][:third] = course.groups.find_by_project_name(params[:preference][:third]).id
        @preference = Preference.new(preference_params) 
        Preference.where(student_id: params[:preference][:student_id], course_id: params[:preference][:course_id]).destroy_all
        if (@preference.save)
          flash[:success] = "Thanks for submitting your preference!"
          redirect_to @preference.student
        else
          redirect_to new_preference_path(course: course)
        end
    end
    
    private
    
    def preference_params
          params.require(:preference).permit(:first, :second, :third, :student_id, :course_id)
    end
end
    


    

