class AddVfistToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :vfirst, :integer, :default=>0
  end
end
