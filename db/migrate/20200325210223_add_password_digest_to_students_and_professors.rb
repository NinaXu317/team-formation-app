class AddPasswordDigestToStudentsAndProfessors < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :password_digest, :string
    add_column :professors, :password_digest, :string
  end
end
