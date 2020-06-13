class Issue < ApplicationRecord
  belongs_to :group
  belongs_to :position, optional: true

  has_many :positions, dependent: :destroy
  has_many :supports, through: :positions
  has_many :subscribed_supports, -> { subscribed }, through: :positions, source: :supports
  has_many :subscribed_users, through: :subscribed_supports, source: :user

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
