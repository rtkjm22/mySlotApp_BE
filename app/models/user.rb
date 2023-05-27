class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  self.primary_key = 'unique_id'
  before_create :set_unique_id
  before_save { email.downcase! }

  has_secure_password
  validates :unique_id, length: { maximum: 10 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8, maximum: 30 }, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true, length: { minimum: 8, maximum: 30 },
                                    format: { with: VALID_PASSWORD_REGEX }

  has_many :scores, foreign_key: 'unique_id', primary_key: 'unique_id'

  private

  def set_unique_id
    self.unique_id = loop do
      random_token = rand(10**10).to_s.rjust(10, "0")
      break random_token unless User.exists?(unique_id: random_token)
    end
  end
end
