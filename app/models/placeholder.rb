class Placeholder < ApplicationRecord
  has_one :profile, as: :userable

  validates :email, email: true
end
