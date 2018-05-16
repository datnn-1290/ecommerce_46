module CartsHelper
  def current_cart
    @current_cart = session[:cart] if session[:cart]
  end

  def total_cart
    total = 0
    session[:cart].each do |item|
      product = Product.find_by id: item["product_id"]
      total += (product.price * item["quantity"].to_i) if item
    end
    total
  end

  def place_an_order
    session[:cart]
  end

  def update_cart
    session[:cart] = @cart
  end
end
