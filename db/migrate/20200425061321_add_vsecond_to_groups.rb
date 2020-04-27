class AddVsecondToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :vsecond, :integer, :default => 0
  end
end
