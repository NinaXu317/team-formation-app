class ChangeVotedToGroupId < ActiveRecord::Migration[6.0]
  def change
    change_column :takings, :voted, 'integer USING CAST(voted AS integer)'
  end
end
