class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }

  NAME_REGEXP = /^[A-Za-z0-9_-]{4,64}$/
  PASSWORD_REGEXP = /^[A-Za-z0-9!@#$%^&*()_+\-=\[\]]{8,64}$/

  validates :name, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  validate do |user|
    if user.errors.where(:name, :taken).none? && (user.name.blank? || !user.name.match?(NAME_REGEXP))
      errors.add(:name, :invalid, message: "длина от 4 до 64, символы A..Z, a..z, 0..9, _, -")
    end
    unless user.password.match?(PASSWORD_REGEXP)
      errors.add(:password, :invalid, message: "длина от 8 до 64, символы A-Z, a-z, 0-9, _, -")
    end
  end
  # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 64 }
  # validates :password, confirmation: true, length: { minimum: 8, maximum: 64 }

  # Errors = Struct.new(:name, :email, :password, :password_confirmation)
end
