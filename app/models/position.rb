class Position < ApplicationRecord
  belongs_to :issue

  has_one :group, through: :issue

  has_many :supports, dependent: :destroy
  has_many :supporting_profiles, through: :supports, source: :profile
  has_many :issues, dependent: :nullify

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
