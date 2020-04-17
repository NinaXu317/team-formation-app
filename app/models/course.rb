class Course < ApplicationRecord
    has_many :takings
    has_many :students, through: :takings
    has_many :preferences
    has_many :groups, -> { order(position: :asc)}, dependent: :destroy
    has_many :holdprojects, -> { order(position: :asc)}, dependent: :destroy
    belongs_to :professor
    validates :pin, uniqueness: true
end
