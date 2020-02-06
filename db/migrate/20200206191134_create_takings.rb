class CreateTakings < ActiveRecord::Migration[6.0]
  def change
    create_table :takings do |t|
      t.integer :student_id
      t.integer :course_id
      t.integer :group_id

      t.timestamps
    end
  end
end
