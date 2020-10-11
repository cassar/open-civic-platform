class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validate :url_must_be_valid

  private

  def url_must_be_valid
    LinkThumbnailer.generate(url)
  rescue LinkThumbnailer::Exceptions => e
    errors.add(:url, e.message)
  end
end
