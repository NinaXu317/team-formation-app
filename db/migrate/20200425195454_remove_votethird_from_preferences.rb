class RemoveVotethirdFromPreferences < ActiveRecord::Migration[6.0]
  def change

    remove_column :preferences, :votethird, :integer
  end
end
