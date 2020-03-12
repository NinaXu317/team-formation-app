class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
