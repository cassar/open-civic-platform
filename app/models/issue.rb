class Issue < ApplicationRecord
  belongs_to :group
  has_many :positions, dependent: :destroy
  has_many :supports, through: :positions

  validates :name, presence: true
end
