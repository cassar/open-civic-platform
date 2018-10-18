class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable, :confirmable, :lockable,
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :timeoutable
end
