class Cart
  attr_accessor :items

  def initialize items = []
    @items = items
  end

  class << self
    def build_cart cart
      items = if cart
        cart["items"].map do |item|
          Item.new item["product_id"], item["quantity"]
        end
      else
        Array.new
      end
      new items
    end
  end

  def update_quantity_item product_id, quantity
    item = @items.find{|item| item.product_id == product_id}
    if item.present?
      item.increment quantity.to_i
    else
      @items << Item.new(product_id, Settings.cart.default_quantity)
    end
  end

  def total_order
    total = 0
    @items.each do |item|
      total +=item.total_price
    end
    total
  end

end
