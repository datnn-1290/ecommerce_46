class Item
  attr_accessor :product_id, :quantity

  def initialize product_id, quantity
    @product_id = product_id
    @quantity = quantity
  end

  def unit_price
    product = Product.find_by id: @product_id
    product.price
  end

  def total_price
    unit_price * quantity
  end

  def increment qty
    @quantity += qty
  end
end
