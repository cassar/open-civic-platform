class Issue < ApplicationRecord
  belongs_to :group

  validates :name, presence: true
end
