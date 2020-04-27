class AddVthirdToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :Vthird, :integer, :default => -1
  end
end
