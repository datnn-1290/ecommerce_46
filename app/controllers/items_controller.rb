class ItemsController < ApplicationController
  before_action :load_product, only: %i(create)

  def show; end

  def create
    unless session[:cart].present?
      session[:cart] = []
    end
    item = Item.new params[:product_id], Settings.cart.default_quantity
    index = session[:cart].find_index{|e| e["product_id"] == params[:product_id]}
    if index.nil?
      session[:cart] << item
      @cart = session[:cart]
    else
      quantity = session[:cart][index]["quantity"].to_i
      quantity += Settings.cart.default_quantity
      session[:cart][index]["quantity"] = quantity
    end
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def destroy
    current_cart.delete_if {|item| item["product_id"] == params[:product_id]}
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    error_redirect unless @product
  end
end
