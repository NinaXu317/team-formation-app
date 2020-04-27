class RemoveVoteFromGroups < ActiveRecord::Migration[6.0]
  def change

    remove_column :groups, :vote, :integer
  end
end
