class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email_address

  validates :email_address, presence: true
  validates :password_digest, presence: true
end
