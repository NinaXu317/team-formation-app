class PreferencesController < ApplicationController
    def index
        @preferences = Preference.all
    end
    
    def new 
        @preference = Preference.new
    end

    def create
        @preference = Preference.new(preference_params)   
        if @preference.save
          flash[:success] = "Thanks for submitting your preference!"
          redirect_to @preference.student
        else
          render 'new'
        end
    end
    
    private
    
    def preference_params
          params.require(:preference).permit(:first, :second, :third)
    end
end
    


    

