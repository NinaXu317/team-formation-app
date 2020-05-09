class AddActivationToProfessors < ActiveRecord::Migration[6.0]
  def change
    add_column :professors, :activation_digest, :string
    add_column :professors, :activated, :boolean
  end
end
