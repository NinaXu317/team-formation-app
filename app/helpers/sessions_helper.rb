module SessionsHelper
    # Logs in the given user.
    def log_in(user, type)
      session[:user_id] = user.id
      session[:type] = type
    end

    # Returns the current logged-in user (if any).
    def current_user
        if session[:type] == "student"
            current_student()
        elsif session[:type] == "professor"
            current_professor()
        else
            @current_user = "ERROR: NO USER TYPE"
        end
    end

    def current_user_type
        session[:type]
    end

    def profile_url
      "/" + current_user_type + "s/" + session[:user_id].to_s
    end
    
    def current_student
      @current_user ||= Student.find_by(id: session[:user_id])
    end

    def current_professor
        @current_user ||= Professor.find_by(id: session[:user_id])
    end
  
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
      !session[:user_id].nil?
    end
  
    # Logs out the current user.
    def log_out
      session.delete(:user_id)
      session.delete(:type)
      @current_user = nil
    end
end