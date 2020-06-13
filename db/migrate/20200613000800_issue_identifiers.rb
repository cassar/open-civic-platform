class IssueIdentifiers < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :identifier, :string
    add_index :issues, :identifier
    Issue.all.each do |issue|
      issue.validate
      issue.save
    end
  end
end
