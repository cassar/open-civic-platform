class Support < ApplicationRecord
  belongs_to :position
  belongs_to :adoption

  has_one :profile, through: :adoption
  has_one :issue, through: :adoption

  has_one :user, through: :profile, source: :userable, source_type: 'User'

  scope :subscribed, -> { where subscribed: true }

  validates :adoption, uniqueness: { scope: :position, message: 'Position already supported' }
end
