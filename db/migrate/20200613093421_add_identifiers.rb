class AddIdentifiers < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :identifier, :string
    add_index :groups, :identifier
    Group.all.each do |group|
      group.validate
      group.save
    end

    add_column :positions, :identifier, :string
    add_index :positions, :identifier
    Position.all.each do |position|
      position.validate
      position.save
    end
  end
end
