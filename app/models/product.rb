class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User'

  validates :amount_available, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :seller,
            inclusion: { in: User.seller, message: 'The provided user is not a seller' }
end
