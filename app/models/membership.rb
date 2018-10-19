class Membership < ApplicationRecord
  MEMBER = 'Member'.freeze
  INVITEE = 'Invitee'.freeze
  REQUESTER = 'Requester'.freeze

  STATUS_TYPES = [MEMBER, INVITEE, REQUESTER].freeze

  validates :status, inclusion: { in: STATUS_TYPES }
end
