class Student < ApplicationRecord
    has_many :takings
    has_many :courses, through: :takings
    has_many :groups, through: :takings
end
