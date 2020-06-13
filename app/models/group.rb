class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :profiles, through: :memberships
  has_many :issues, dependent: :destroy

  has_many :confirmed_memberships, -> { confirmed }, class_name: 'Membership'
  has_many :confirmed_subscribed_memberships, -> { confirmed.subscribed }, class_name: 'Membership'

  has_many :confirmed_profiles, through: :confirmed_memberships, source: :profile
  has_many :confirmed_subscribed_profiles, through: :confirmed_subscribed_memberships, source: :profile

  has_many :confirmed_subscribed_users, through: :confirmed_subscribed_profiles, source: :userable, source_type: 'User'

  has_many :invitations, -> { invited }, class_name: 'Membership'
  has_many :invited_profiles, through: :invitations, source: :profile

  validates :name, :identifier, uniqueness: true, presence: true

  before_validation :generate_identifier

  def to_param
    identifier
  end

  private

  def generate_identifier
    self.identifier = name&.gsub(' ', '_')&.gsub(/\W/, '')&.downcase
  end
end
