class Support < ApplicationRecord
  belongs_to :position
  belongs_to :adoption

  has_one :profile, through: :adoption
  has_one :issue, through: :adoption

  has_one :user, through: :profile, source: :userable, source_type: 'User'

  has_many :family, through: :adoption, source: :supports

  scope :subscribed, -> { where subscribed: true }

  scope :where_issue, lambda { |issue|
    joins(:adoption).where(adoptions: {issue: issue}).distinct
  }

  validates :adoption, uniqueness: { scope: :position, message: 'Position already supported' }

  validates :preference, presence: true

  def up_preference
    preference + 1
  end

  def down_preference
    preference - 1
  end

  def first_preference
    1
  end
end
