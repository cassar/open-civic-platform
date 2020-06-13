class Position < ApplicationRecord
  has_many :supports, dependent: :destroy
  has_many :supporting_profiles, through: :supports, source: :profile

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
