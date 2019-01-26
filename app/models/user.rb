class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable, :confirmable, :lockable, ,
  devise :database_authenticatable, :registerable, :rememberable,
         :trackable, :validatable, :timeoutable, :recoverable

  has_one :profile, as: :userable, dependent: :destroy

  has_many :memberships, through: :profile
  has_many :groups, through: :memberships
  has_many :confirmed_memberships, through: :profile
  has_many :invitations, through: :profile

  after_create :link_to_profile

  private

  def link_to_profile
    Profile.create(userable: self)
  end
end
