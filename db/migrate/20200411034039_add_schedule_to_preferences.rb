class AddScheduleToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :schedule, :string
  end
end
