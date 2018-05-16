module CartsHelper
  def find_product_by_id id
    @product = Product.find_by id: id
  end

  def current_cart
    @current_cart = session[:cart]["items"] if session[:cart]
  end

  def create_cart
    unless @cart.present?
      @cart = Cart.build_cart session[:cart]
    end
  end

  def update_cart
    session[:cart] = @cart
  end
end
