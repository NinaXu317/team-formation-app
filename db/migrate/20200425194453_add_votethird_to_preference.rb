class AddVotethirdToPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :votethird, :integer
  end
end
