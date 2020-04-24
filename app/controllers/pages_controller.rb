class PagesController < ApplicationController
  def home
    if logged_in?
      redirect_to current_user
    else
      @courses = Course.all
      @groups = Group.all
      @professors = Professor.all
      @students = Student.all
    end
  end
end
