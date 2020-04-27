class AddVotethirdToTaking < ActiveRecord::Migration[6.0]
  def change
    add_column :takings, :votethird, :integer, :default => -1
  end
end
