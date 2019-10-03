class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  after_initialize :set_default_role, if: :new_record?

  has_many :plans, dependent: :destroy
  has_many :spheres, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :visions, dependent: :destroy
  has_many :csfs, dependent: :destroy

  enum role: [:user, :admin]

  validates :name, presence: true
  validates :email, presence: true

  def set_default_role
    self.role ||= :user
  end
end
