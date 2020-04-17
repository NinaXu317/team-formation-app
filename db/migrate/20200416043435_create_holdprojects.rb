class CreateHoldprojects < ActiveRecord::Migration[6.0]
  def change
    create_table :holdprojects do |t|
      t.string :course_id
      t.string :project_name
      t.integer :position

      t.timestamps
    end
  end
end
