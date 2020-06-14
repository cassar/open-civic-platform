class RemoveIssuePosition < ActiveRecord::Migration[6.0]
  def change
    remove_column :issues, :position_id
  end
end
