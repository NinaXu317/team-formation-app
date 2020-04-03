class AddCourseIdToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :course_id, :integer
  end
end
