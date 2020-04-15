class AddHoldToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :hold, :boolean, :default => false
  end
end
