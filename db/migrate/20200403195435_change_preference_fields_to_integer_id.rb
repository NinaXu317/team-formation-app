class ChangePreferenceFieldsToIntegerId < ActiveRecord::Migration[6.0]
  def change
    change_column :preferences, :first, 'integer USING CAST(first AS integer)'
    change_column :preferences, :second, 'integer USING CAST(second AS integer)'
    change_column :preferences, :third, 'integer USING CAST(third AS integer)'
  end
end
