class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :profiles, through: :memberships

  has_many :confirmed_memberships, -> { confirmed }, class_name: 'Membership'
  has_many :confirmed_profiles, through: :confirmed_memberships, source: :profile

  has_many :invitations, -> { invited }, class_name: 'Membership'

  validates :name, presence: true
end
