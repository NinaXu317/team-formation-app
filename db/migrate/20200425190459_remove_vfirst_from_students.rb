class RemoveVfirstFromStudents < ActiveRecord::Migration[6.0]
  def change

    remove_column :students, :Vfirst, :integer
  end
end
