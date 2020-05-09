class AccountActivationsController < ApplicationController

    def edit
        user = Student.find_by(email: params[:email])
        type = "student"
        if !user
            user = Professor.find_by(email: params[:email])
            type = "professor"
        end
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          log_in(user, type)
          redirect_to user, notice: "Account activated!"
        else
          redirect_to root_url, notice: "Invalid activation link"
        end
    end

end
