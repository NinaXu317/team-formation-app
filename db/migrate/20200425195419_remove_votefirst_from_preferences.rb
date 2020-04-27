class RemoveVotefirstFromPreferences < ActiveRecord::Migration[6.0]
  def change

    remove_column :preferences, :votefirst, :integer
  end
end
