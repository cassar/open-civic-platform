class Position < ApplicationRecord
  belongs_to :issue

  has_one :group, through: :issue

  has_many :confirmed_users, through: :group
  has_many :supports, dependent: :destroy

  validates :name, presence: true
end
