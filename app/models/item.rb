class Item
  attr_accessor :product_id, :quantity, :total_price

  def initialize product_id, quantity
    @product_id = product_id
    @quantity = quantity
  end

  def unit_price
    product = Product.find_by id: @product_id
    @total_price = product.price.to_i * quantity.to_i
    product.price
  end
end
