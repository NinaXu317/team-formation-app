class Preference < ApplicationRecord
  belongs_to :student
  belongs_to :course
  def choicesArePresent
    return !Group.where(course_id: course_id, id: first).empty? && 
           !Group.where(course_id: course_id, id: second).empty? && 
           !Group.where(course_id: course_id, id: third).empty?
  end
end
