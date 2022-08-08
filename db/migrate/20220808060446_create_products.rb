class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :amount_available
      t.integer :price
      t.integer :seller_id

      t.timestamps
    end
  end
end
