class AddUserRefToProducts < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key(:products, :users, column: :seller_id)
  end
end
