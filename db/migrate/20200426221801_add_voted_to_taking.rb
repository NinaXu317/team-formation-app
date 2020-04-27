class AddVotedToTaking < ActiveRecord::Migration[6.0]
  def change
    add_column :takings, :voted, :boolean
  end
end
