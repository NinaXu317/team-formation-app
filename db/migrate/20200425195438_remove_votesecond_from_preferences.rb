class RemoveVotesecondFromPreferences < ActiveRecord::Migration[6.0]
  def change

    remove_column :preferences, :votesecond, :integer
  end
end
