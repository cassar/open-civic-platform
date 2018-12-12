class Issue < ApplicationRecord
  belongs_to :group
  has_many :positions, dependent: :destroy

  validates :name, presence: true
end
