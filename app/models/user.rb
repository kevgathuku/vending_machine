class User < ApplicationRecord
  enum role: { buyer: 0, seller: 1 }

  validates :username, presence: true, uniqueness: true

  has_secure_password

  has_many :products, foreign_key: 'seller', inverse_of: 'seller'
end
