class Issue < ApplicationRecord
  belongs_to :group
  belongs_to :position, optional: true

  has_many :positions, dependent: :destroy
  has_many :supports, through: :positions
  has_many :subscribed_supports, -> { subscribed }, through: :positions, source: :supports
  has_many :subscribed_users, through: :subscribed_supports, source: :user

  validates :name, presence: true
end
