class AddVoteToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :vote, :integer
  end
end
