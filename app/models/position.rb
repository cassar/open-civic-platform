class Position < ApplicationRecord
  belongs_to :issue

  has_many :supports, dependent: :destroy

  validates :name, presence: true
end
