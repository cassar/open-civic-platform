class Placeholder < ApplicationRecord
  has_one :profile, as: :userable

  validates :email, email: { message: 'format not recognised' }

  after_create :link_to_profile

  private

  def link_to_profile
    Profile.create userable: self
  end
end
