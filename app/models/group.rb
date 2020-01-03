class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :profiles, through: :memberships
  has_many :issues, dependent: :destroy

  has_many :confirmed_memberships, -> { confirmed }, class_name: 'Membership'
  has_many :confirmed_profiles, through: :confirmed_memberships, source: :profile

  has_many :invitations, -> { invited }, class_name: 'Membership'
  has_many :invited_profiles, through: :invitations, source: :profile

  validates :name, presence: true
end
