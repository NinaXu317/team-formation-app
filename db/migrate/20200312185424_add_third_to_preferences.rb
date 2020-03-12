class AddThirdToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :third, :string
  end
end
