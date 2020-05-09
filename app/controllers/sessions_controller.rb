class SessionsController < ApplicationController

  def new
  end

  def new_student
    @type = "student"
    render 'new'
  end

  def new_professor
    @type = "professor"
    render 'new'
  end

  def create
    user = nil
    type = params[:type][:field]
    if type == "student"
      user = Student.find_by_email(params[:email])
    elsif type == "professor"
      user = Professor.find_by_email(params[:email])
    end

    if user && user.authenticate(params[:password])
      if user.activated?
        log_in(user, type)
        redirect_to root_url, notice: "Logged in!"
      else
        redirect_to root_url, notice: "Account not activated. Check email for the activation link."
      end
    else
      if type == "student"
        redirect_to student_login_path, notice: "Invalid email or password"
      elsif type == "professor"
        redirect_to professor_login_path, notice: "Invalid email or password"
      end
    end
  end

  def logout
    log_out()
    redirect_to root_url, notice: "Logged out"
  end
end
