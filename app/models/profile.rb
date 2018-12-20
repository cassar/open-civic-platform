class Profile < ApplicationRecord
  belongs_to :userable, polymorphic: true

  has_many :memberships, dependent: :destroy
  has_many :confirmed_memberships, -> { confirmed }, class_name: 'Membership'
  has_many :invitations, -> { invited }, class_name: 'Membership', dependent: :destroy
  has_many :groups, through: :confirmed_memberships
end
