class Contact < ApplicationRecord
  validates_presence_of :name, :email, :message
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
