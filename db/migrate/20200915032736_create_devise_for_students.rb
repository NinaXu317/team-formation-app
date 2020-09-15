class CreateDeviseForStudents < ActiveRecord::Migration[6.0]
  def change
      
      # Confirmable
      add_column :students, :confirmation_token, :string
      add_column :students, :confirmed_at, :datetime
      add_column :students, :confirmation_sent_at, :datetime
      add_column :students, :unconfirmed_email, :string # Only if using reconfirmable

      # Recoverable
      add_column :students, :reset_password_token, :string
      add_column :students, :reset_password_sent_at, :datetime

      # Rename password_digest to encrypted_password
      rename_column :students, :password_digest, :encrypted_password
  end
end
