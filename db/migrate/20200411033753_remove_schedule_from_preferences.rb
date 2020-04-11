class RemoveScheduleFromPreferences < ActiveRecord::Migration[6.0]
  def change

    remove_column :preferences, :schedule, :string
  end
end
