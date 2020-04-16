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
      puts "logging in"
      log_in(user, type)
      redirect_to root_url, notice: "Logged in!"
    else
      puts "invalid password"
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def logout
    log_out()
    redirect_to root_url, notice: "Logged out"
  end
end
