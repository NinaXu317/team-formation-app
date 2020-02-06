class Group < ApplicationRecord
    has_many :takings
    has_many :students, through: :takings
end
