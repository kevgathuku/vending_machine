class User < ApplicationRecord
  enum role: { buyer: 0, seller: 1 }

  has_secure_password

  has_many :products, foreign_key: 'seller', inverse_of: 'seller'
end
