class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable
  has_many :plans, dependent: :destroy
  has_many :spheres, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :visions, dependent: :destroy
  has_many :csfs, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validate :password_complexity

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    errors.add "Não foi possível salvar o usuário: ", "a sua senha
     deve ter de 8-70 caracteres e incluir: 1 letra maíscula,
     1 letra minúscula, 1 digito numérico e 1 caractere especial."
  end
end
