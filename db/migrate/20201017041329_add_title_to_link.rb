class AddTitleToLink < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :title, :string

    Link.all.each do |link|
      link.update! title: LinkThumbnailer.generate(link.url).title
    end

    raise 'Not all links have titles' if Link.where(title: nil).exists?
  end
end
