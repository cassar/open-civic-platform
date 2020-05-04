class Position < ApplicationRecord
  belongs_to :issue

  has_one :group, through: :issue

  has_many :confirmed_users, through: :group
  has_many :supports, dependent: :destroy
  has_many :supporting_profiles, through: :supports, source: :profile

  validates :name, presence: true
end
