class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  MEMBER = 'Member'.freeze
  INVITEE = 'Invitee'.freeze

  STATUS_TYPES = [MEMBER, INVITEE].freeze

  validates :status, inclusion: { in: STATUS_TYPES }

  validates :group_id, uniqueness: { scope: :user_id,
                                     message: 'Membership already exists.' }

  after_destroy :could_the_last_one_out_please_shut_the_door

  def self.new_member
    new(status: MEMBER)
  end

  def accept_invitation
    update(status: MEMBER)
  end

  def member?
    status == MEMBER
  end

  def invitee?
    status == INVITEE
  end

  def could_the_last_one_out_please_shut_the_door
    return unless group.memberships.empty?
    group.destroy
  end
end
