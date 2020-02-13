class PagesController < ApplicationController
  def home
    @courses = Course.all
    @groups = Group.all
    @professors = Professor.all
    @students = Student.all
  end
end
