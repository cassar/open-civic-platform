class AddPositionToIssue < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :position_id, :integer
    add_index :issues, :position_id
  end
end
