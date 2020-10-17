class Issue < ApplicationRecord
  has_many :adoptions, dependent: :destroy
  has_many :supports, through: :adoptions
  has_many :positions, through: :supports
  has_many :submissisons
  has_many :groups, through: :submissions
  has_many :links, as: :linkable, dependent: :destroy

  validates :name, uniqueness: true, presence: true

end
