module CartsHelper
  def find_product_by_id id
    @product = Product.find_by id: id
  end

  def current_cart
    @cart = session[:cart]["items"] if session[:cart]
  end
end
