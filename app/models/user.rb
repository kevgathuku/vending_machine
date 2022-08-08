class User < ApplicationRecord
  enum role: { buyer: 0, seller: 1 }

  has_secure_password
end
