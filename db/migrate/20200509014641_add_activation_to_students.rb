class AddActivationToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :activation_digest, :string
    add_column :students, :activated, :boolean
  end
end
