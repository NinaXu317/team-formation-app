class AddPositionToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :position, :integer
  end
end
