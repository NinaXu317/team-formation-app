class RemoveVthirdFromStudents < ActiveRecord::Migration[6.0]
  def change

    remove_column :students, :Vthird, :integer
  end
end
