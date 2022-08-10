class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User'

  validates :seller,
            inclusion: { in: User.seller, message: 'The provided user is not a seller' }
end
