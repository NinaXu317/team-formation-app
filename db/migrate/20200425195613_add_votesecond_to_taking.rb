class AddVotesecondToTaking < ActiveRecord::Migration[6.0]
  def change
    add_column :takings, :votesecond, :integer, :default=> -1
  end
end
