class Student < ApplicationRecord
    has_many :takings
    has_many :courses, through: :takings
    has_many :groups, through: :takings
    accepts_nested_attributes_for :courses, allow_destroy: true
    has_secure_password
end
