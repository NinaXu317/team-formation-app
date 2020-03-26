class AddDreampartnerToPerference < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :dreampartner, :string
  end
end
