class Position < ApplicationRecord
  belongs_to :issue

  validates :name, presence: true
end
