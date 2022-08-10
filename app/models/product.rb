class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User'

  validates :seller_id, inclusion: { in: User.seller.pluck(:id),
                                     message: '%{value} is not a valid seller ID' }
end
