class SupportPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :supports, :preference, :integer
    add_index :supports, :preference

    Adoption.all.preload(:supports).each do |adoption|
      adoption.supports.each_with_index do |support, index|
        support.update! preference: (index + 1)
      end
    end
  end
end
