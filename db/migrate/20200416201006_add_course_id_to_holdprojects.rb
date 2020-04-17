class AddCourseIdToHoldprojects < ActiveRecord::Migration[6.0]
  def change
    add_column :holdprojects, :course_id, :integer
  end
end
