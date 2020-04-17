class Holdproject < ApplicationRecord
    acts_as_list scope: :course
    belongs_to :course
end
