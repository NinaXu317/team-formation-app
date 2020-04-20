class ChangeDreamPartnerToInt < ActiveRecord::Migration[6.0]
  def change
    change_column :preferences, :dreampartner, 'integer USING CAST(first AS integer)'
  end
end
