class AddVotesecondToPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :votesecond, :integer
  end
end
