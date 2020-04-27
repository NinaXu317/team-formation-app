class AddDescriptionToHoldprojects < ActiveRecord::Migration[6.0]
  def change
    add_column :holdprojects, :description, :text
  end
end
