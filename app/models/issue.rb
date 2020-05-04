class Issue < ApplicationRecord
  belongs_to :group
  belongs_to :position, optional: true

  has_many :positions, dependent: :destroy
  has_many :supports, through: :positions
  has_many :supporter_users, through: :supports, source: :user

  validates :name, presence: true
end
