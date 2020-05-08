class Course < ApplicationRecord
    has_many :takings
    has_many :students, through: :takings
    has_many :preferences
    has_many :groups, -> { order(position: :asc)}, dependent: :destroy
    has_many :holdprojects, -> { order(position: :asc)}, dependent: :destroy
    belongs_to :professor
    validates :pin, uniqueness: true

    def active_groups
        groups = Group.where(course_id: id).all
        puts groups.inspect
        active_groups = 0
        groups.each do |group|
            if group.active
                active_groups += 1
            end
        end
        puts "ACTIVE GROUPS: " + active_groups.inspect
        return active_groups
    end

    def has_enough_projects
        return active_groups() >= 3
    end
end
