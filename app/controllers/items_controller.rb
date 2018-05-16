class ItemsController < ApplicationController

  def show; end

  def create
    unless session[:cart].present?
      session[:cart] = []
    end
    item = Item.new params[:product_id], params[:quantity]
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

  def update
    if @item.present?
      @item.quantity = params[:quantity].to_i
      respond_to do |format|
        format.html{redirect_to request.referrer}
        format.js
      end
    else
      flash[:danger] = t ".failed"
    end
  end

  def destroy
    current_cart.delete_if {|item| item["product_id"] == params[:product_id]}
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
