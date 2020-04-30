class Preference < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :first,  presence: true
  validates :second,  presence: true
  validates :third,  presence: true
  validates :codingProficiency,  presence: true
  validates :schedule,  presence: true

  validate :first_and_second_not_equal
  validate :first_and_third_not_equal
  validate :second_and_third_not_equal

  validate :first_choice_is_present
  validate :second_choice_is_present
  validate :third_choice_is_present

  def first_and_second_not_equal
    errors.add(:first, "can't be the same as second choice") if first == second
  end

  def first_and_third_not_equal
    errors.add(:first, "can't be the same as third choice") if first == third
  end

  def second_and_third_not_equal
    errors.add(:second, "can't be the same as third choice") if third == second
  end

  def first_choice_is_present
    errors.add(:first, "project choice must exist") if !Group.where(course_id: course_id, id: first).empty?
  end

  def second_choice_is_present
    errors.add(:second, "project choice must exist") if !Group.where(course_id: course_id, id: second).empty?
  end

  def third_choice_is_present
    errors.add(:third, "project choice must exist") if !Group.where(course_id: course_id, id: third).empty?
  end
    
  def choicesArePresent
    return !Group.where(course_id: course_id, id: first).empty? && 
           !Group.where(course_id: course_id, id: second).empty? && 
           !Group.where(course_id: course_id, id: third).empty?
  end
end
