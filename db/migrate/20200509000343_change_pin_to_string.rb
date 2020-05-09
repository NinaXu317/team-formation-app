class ChangePinToString < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :pin, :string
  end
end
