class Adoption < ApplicationRecord
  belongs_to :profile
  belongs_to :issue

  has_many :supports, dependent: :destroy

  validates :profile, uniqueness: { scope: :issue, message: 'Issue already adopted' }
end
