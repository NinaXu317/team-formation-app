class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :pin
      t.integer :professor_id

      t.timestamps
    end
  end
end
