class RemoveCourseIdFromHoldprojects < ActiveRecord::Migration[6.0]
  def change

    remove_column :holdprojects, :course_id, :string
  end
end
