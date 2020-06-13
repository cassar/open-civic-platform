class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.integer :group_id
      t.integer :issue_id

      t.timestamps
    end

    Issue.all.each { |issue| Submission.create! group_id: issue.group_id, issue: issue }

    remove_column :issues, :group_id

    add_column :supports, :issue_id, :integer
    add_index :supports, :issue_id
    add_column :supports, :profile_id, :integer
    add_index :supports, :profile_id

    Support.all.each do |support|
      support.update!(
        issue_id: support.position.issue_id,
        profile_id: Membership.find(support.membership_id).profile_id
      )
    end

    remove_column :positions, :issue_id
    remove_column :supports, :membership_id
  end
end
