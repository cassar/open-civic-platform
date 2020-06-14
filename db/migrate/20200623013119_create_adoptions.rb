class CreateAdoptions < ActiveRecord::Migration[6.0]
  def change
    create_table :adoptions do |t|
      t.integer :profile_id
      t.integer :issue_id

      t.timestamps
    end

    add_column :supports, :adoption_id, :integer
    add_index :supports, :adoption_id

    Support.all.each do |support|
      support.update! adoption_id: Adoption.find_or_create_by!(
        issue_id: support.issue_id,
        profile_id: support.profile_id
      ).id
    end

    remove_column :supports, :profile_id
    remove_column :supports, :issue_id
  end
end
