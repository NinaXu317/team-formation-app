class AddVotefirstToTaking < ActiveRecord::Migration[6.0]
  def change
    add_column :takings, :votefirst, :integer, :default=> -1
  end
end
