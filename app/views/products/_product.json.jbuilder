json.extract! product, :id, :name, :amount_available, :price, :seller_id, :created_at, :updated_at
json.url product_url(product, format: :json)
