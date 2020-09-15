class CreateDeviseForProfessors < ActiveRecord::Migration[6.0]
  def change
      # Confirmable
      add_column :professors, :confirmation_token, :string
      add_column :professors, :confirmed_at, :datetime
      add_column :professors, :confirmation_sent_at, :datetime
      add_column :professors, :unconfirmed_email, :string # Only if using reconfirmable

      # Recoverable
      add_column :professors, :reset_password_token, :string
      add_column :professors, :reset_password_sent_at, :datetime

      # Rename password_digest to encrypted_password
      rename_column :professors, :password_digest, :encrypted_password
  end
end
