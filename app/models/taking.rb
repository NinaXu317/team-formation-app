class Taking < ApplicationRecord
    belongs_to :student
    belongs_to :course
    belongs_to :group, optional: true
    validates :student_id, uniqueness: { scope: :course_id, message: "Only  allowed to enroll in course once" }
end
