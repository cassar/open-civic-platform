class Issue < ApplicationRecord
  has_many :adoptions, dependent: :destroy
  has_many :supports, through: :adoptions
  has_many :positions, through: :supports
  has_many :submissisons
  has_many :groups, through: :submissions
  has_many :links, as: :linkable, dependent: :destroy

  validates :name, :identifier, uniqueness: true, presence: true

  before_validation :generate_identifier

  private

  def generate_identifier
    self.identifier = name&.gsub(' ', '_')&.gsub(/\W/, '')&.downcase
  end
end
