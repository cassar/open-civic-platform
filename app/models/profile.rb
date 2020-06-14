class Profile < ApplicationRecord
  belongs_to :userable, polymorphic: true

  has_many :memberships, dependent: :destroy
  has_many :confirmed_memberships, -> { confirmed }, class_name: 'Membership'
  has_many :invitations, -> { invited }, class_name: 'Membership', dependent: :destroy
  has_many :groups, through: :confirmed_memberships

  has_many :adoptions, dependent: :destroy
  has_many :issues_adopted, through: :adoptions, source: :issue
  has_many :supports, through: :adoptions
  has_many :issues_supporting, through: :supports, source: :issue
end
