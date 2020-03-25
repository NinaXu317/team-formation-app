class AddCodingProficiencyToPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :codingProficiency, :integer
  end
end
