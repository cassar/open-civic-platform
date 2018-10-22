class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  validates :name, presence: true

  def create_new_member(user)
    member = Membership.new_member
    member.user = user
    member.group = self
    member.save
  end
end
