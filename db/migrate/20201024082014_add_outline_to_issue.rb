class AddOutlineToIssue < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :outline, :text
  end
end
