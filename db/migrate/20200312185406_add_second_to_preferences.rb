class AddSecondToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :second, :string
  end
end
