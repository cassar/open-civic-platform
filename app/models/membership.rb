class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  MEMBER = 'Member'.freeze
  INVITEE = 'Invitee'.freeze
  REQUESTER = 'Requester'.freeze

  STATUS_TYPES = [MEMBER, INVITEE, REQUESTER].freeze

  validates :status, inclusion: { in: STATUS_TYPES }

  validates :group_id, uniqueness: { scope: :user_id,
                                     message: 'Membership already exists.' }

  def self.new_requester
    new(status: REQUESTER)
  end

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

  def requester?
    status == REQUESTER
  end
end
