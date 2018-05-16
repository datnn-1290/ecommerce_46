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
end
