class RemoveVsecondFromStudents < ActiveRecord::Migration[6.0]
  def change

    remove_column :students, :Vsecond, :integer
  end
end
