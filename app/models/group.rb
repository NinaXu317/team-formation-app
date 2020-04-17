class Group < ApplicationRecord
    acts_as_list scope: :course
    has_many :takings
    has_many :students, through: :takings
    belongs_to :course
end
