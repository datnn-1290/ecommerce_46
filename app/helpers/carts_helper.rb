module CartsHelper
  def current_cart
    @current_cart = session[:cart] if session[:cart]
  end

  def total_cart
    total = 0
    session[:cart].each do |item|
      total += (item["price"].to_i * item["quantity"].to_i) if item
    end
    total
  end

  def save_order_detail cart
    session[:cart].each do |item|
      order_detail = OrderDetail.new(item["product_id"], item["quantity"], item["price"], order.id)
      order_detail.save!
    end

  end
end
