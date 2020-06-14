class Issue < ApplicationRecord
  has_many :supports, dependent: :destroy
  has_many :positions, through: :supports
  has_many :submissisons
  has_many :groups, through: :submissions

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
