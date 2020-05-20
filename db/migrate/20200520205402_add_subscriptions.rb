class AddSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :subscribed, :boolean
    add_index :memberships, :subscribed
    add_column :supports, :subscribed, :boolean
    add_index :supports, :subscribed
  end
end
