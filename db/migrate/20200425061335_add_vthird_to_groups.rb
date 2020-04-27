class AddVthirdToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :vthird, :integer, :default => 0
  end
end
