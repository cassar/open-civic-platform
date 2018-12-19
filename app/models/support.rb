class Support < ApplicationRecord
  belongs_to :membership
  belongs_to :position

  has_one :issue, through: :position

  validate :only_one_support_per_issue

  private

  def only_one_support_per_issue
    support = issue.supports.find_by(membership: membership)
    return unless support.present? && support != self

    errors.add(:membership, 'Can only support one position per issue.')
  end
end
