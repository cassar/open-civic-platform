class Membership < ApplicationRecord
  MEMBER = 'Member'.freeze
  INVITEE = 'Invitee'.freeze

  STATUS_TYPES = [MEMBER, INVITEE].freeze

  belongs_to :profile
  belongs_to :group

  scope :confirmed, -> { where status: MEMBER }
  scope :invited, -> { where status: INVITEE }
  scope :subscribed, -> { where subscribed: true }

  validates :status, inclusion: { in: STATUS_TYPES }
  validates :group_id, uniqueness: { scope: :profile_id,
                                     message: 'Membership already exists.' }

  after_destroy :could_the_last_one_out_please_shut_the_door

  def could_the_last_one_out_please_shut_the_door
    return unless group.memberships.confirmed.empty?

    group.destroy
  end

  def accept_invitation
    update(status: MEMBER)
  end

  def confirmed?
    status == MEMBER
  end

  def invited?
    status == INVITEE
  end
end
