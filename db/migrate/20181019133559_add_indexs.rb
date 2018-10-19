class AddIndexs < ActiveRecord::Migration[5.2]
  def change
    add_index :memberships, :group_id
    add_index :memberships, :user_id
  end
end
