class Support < ApplicationRecord
  belongs_to :position
  belongs_to :issue
  belongs_to :profile

  has_one :user, through: :profile, source: :userable, source_type: 'User'

  scope :subscribed, -> { where subscribed: true }
end
