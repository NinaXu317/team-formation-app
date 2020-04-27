class AddVfirstToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :Vfirst, :integer, :default => -1
  end
end
