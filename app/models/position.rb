class Position < ApplicationRecord
  has_many :supports, dependent: :destroy
  has_many :adoptions, through: :supports
  has_many :supporting_profiles, through: :adoptions, source: :profile

  scope :where_issue, lambda { |issue|
    joins(:adoptions).where(adoptions: {issue: issue}).distinct
  }

  validates :name, uniqueness: true, presence: true
end
