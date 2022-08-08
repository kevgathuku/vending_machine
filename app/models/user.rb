class User < ApplicationRecord
  enum role: { buyer: 0, seller: 1 }
end
