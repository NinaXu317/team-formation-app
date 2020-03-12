class PreferencesController < ApplicationController
    def index
        @preferences = Preference.all
    end
    
    def new 
        @preference = Preference.new
    end
end
