class AddFirstToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :first, :string
  end
end
