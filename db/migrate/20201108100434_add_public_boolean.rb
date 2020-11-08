class AddPublicBoolean < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :published, :boolean
    add_column :positions, :published, :boolean

    add_index :issues, :published
    add_index :positions, :published
  end
end
