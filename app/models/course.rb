class Course < ApplicationRecord
    has_many :takings
    has_many :students, through: :takings
    has_many :groups
end
