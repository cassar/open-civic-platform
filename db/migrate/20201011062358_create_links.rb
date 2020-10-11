class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url
      t.references :linkable, polymorphic: true

      t.timestamps
    end
  end
end
