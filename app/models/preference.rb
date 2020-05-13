class Preference < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :student_id, uniqueness: { scope: :course_id, message: "Only one preference allowed per student per course" }
  validates :first,  presence: { message: "First choice can't be blank" }
  validates :second,  presence: { message: "Second choice can't be blank" }
  validates :third,  presence: { message: "Third choice can't be blank" }
  validates :codingProficiency,  presence: { message: "Coding Proficiency can't be blank" }
  validates :schedule,  presence: { message: "Schedule can't be blank" }

  validate :first_and_second_not_equal
  validate :first_and_third_not_equal
  validate :second_and_third_not_equal

  validate :first_choice_is_present
  validate :second_choice_is_present
  validate :third_choice_is_present

  def first_and_second_not_equal
    errors.add(:first, :not_unique, message: "First choice can't be the same as second choice") if !first.nil? && first == second
  end

  def first_and_third_not_equal
    errors.add(:first, :not_unique, message: "First choice can't be the same as third choice") if !first.nil? && first == third
  end

  def second_and_third_not_equal
    errors.add(:second, :not_unique, message: "Second choice can't be the same as third choice") if !third.nil? && third == second
  end

  def first_choice_is_present
    errors.add(:first, :doesnt_exist, message: "First project choice must exist") if !first.nil? && Group.where(course_id: course_id, id: first).empty?
  end

  def second_choice_is_present
    errors.add(:second, :doesnt_exist, message: "Second project choice must exist") if !second.nil? && Group.where(course_id: course_id, id: second).empty?
  end

  def third_choice_is_present
    errors.add(:third, :doesnt_exist, message: "Third project choice must exist") if !third.nil? && Group.where(course_id: course_id, id: third).empty?
  end
    
  def choicesArePresent
    return !Group.where(course_id: course_id, id: first).empty? && 
           !Group.where(course_id: course_id, id: second).empty? && 
           !Group.where(course_id: course_id, id: third).empty?
  end

  def choicesAreValid
    return (Group.where(course_id: course_id, id: first).first.active && 
    Group.where(course_id: course_id, id: second).first.active && 
    Group.where(course_id: course_id, id: third).first.active)
  end
end
