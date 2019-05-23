class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :plans, dependent: :destroy
  has_many :spheres, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :visions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
end
