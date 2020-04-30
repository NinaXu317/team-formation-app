class AddVotingToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :voting, :boolean, :default=>true
  end
end
