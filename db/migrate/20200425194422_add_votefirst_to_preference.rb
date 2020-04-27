class AddVotefirstToPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :votefirst, :integer
  end
end
