class Taking < ApplicationRecord
    belongs_to :student
    belongs_to :course
    belongs_to :groups
end
