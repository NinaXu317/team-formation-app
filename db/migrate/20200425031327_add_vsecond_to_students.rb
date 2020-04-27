class AddVsecondToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :Vsecond, :integer, :default => -1
  end
end
