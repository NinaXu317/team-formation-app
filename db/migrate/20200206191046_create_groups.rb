class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :course_id
      t.string :project_name

      t.timestamps
    end
  end
end
